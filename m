Received: from mta.kiivia.com (mta.kiivia.com [95.217.65.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 628EE4EE852
	for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 20:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.217.65.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790367591; cv=none; b=IYSE3FvyZNOwxx6fSFFZ8lIECSHGyWyN1ng2g39KTjyD6VN+Qgs+mIwOS7JOo6QD7zcSuhy5GJnq+YNUBRMFGf/PzbX7E7nDqcU/7298Ewm8t9ypo5pRGARsTyFDsJnCDu+puqf+kEgtpjiD31pJO+WbnZiaFbAnC9u/fSWhJg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790367591; c=relaxed/simple;
	bh=luiXIOC1T2eWq0OlPq9lqfU/bbQRbV7rPdZEy4pED+U=;
	h=Content-Type:Message-ID:Date:Mime-Version:To:Cc:Subject:From; b=VK2CMGI7njIHjoIHEwrhCe4T1tEdVRypp/a2LI6r0/NXm7KDWxgVD/TK5zEHsKY9c6WEA5L3hiIoOd7HvP8KVK9/lqTOd8qj1AhrpLv3BymecDBBeuLbSBTYsTvwWWNZgPTMOYPM4WIcYw+Qa168uS3Mn3TDpQP/icqDzHCxQFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nocloud.org; spf=pass smtp.mailfrom=nocloud.org; arc=none smtp.client-ip=95.217.65.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nocloud.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nocloud.org
Received: by mta.kiivia.com (Postfix) with ESMTPSA id 32C21A80149;
	Fri, 25 Sep 2026 23:10:21 +0300 (EEST)
Content-Type: multipart/mixed; boundary="------------iMRlo67POggb8WRfMXMlOGf7"
Message-ID: <361df563-e29e-43bf-8806-24bdfefed33d@nocloud.org>
Date: Fri, 25 Sep 2026 23:10:20 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
To: netdev@vger.kernel.org
Cc: sgoutham@marvell.com, gakula@marvell.com, rkannoth@marvell.com,
 sbhatta@marvell.com, bbhushan2@marvell.com,
 linux-yocto@lists.yoctoproject.org
Subject: [BUG] octeontx2-pf: RSS table size is set to 4 instead of 256 entries
Content-Language: en-US
From: Jase <jase@nocloud.org>

This is a multi-part message in MIME format.
--------------iMRlo67POggb8WRfMXMlOGf7
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello,

On an Asterfusion ET2500 with an OCTEON CN102 A0, the Linux RVU PF
driver reports eight RX queues but nearly all RSS indirection entries
point to queue 0. RX queue and interrupt counters confirm that traffic
is heavily concentrated on that queue, with drops under small-packet load.

In otx2_rss_init(), otx2_common.c assigns:

     rss->rss_size = sizeof(*rss->ind_tbl);

ind_tbl is u32 ind_tbl[MAX_RSS_INDIR_TBL_SIZE], where the maximum is 256.
The expression yields 4, not the entry count. RSS initialization and
ethtool get/set loops use rss_size, while NIX LF allocation requests 256.

Observed with Linux-owned physical ports and eight RX/TX queues:

     ethtool -l <interface>
     ethtool -x <interface>

The indirection table begins 0,1,2,3 and all remaining entries are zero.
Running ethtool -X <interface> equal 8 succeeds but leaves this unchanged,
using either netlink or --disable-netlink.

Changing the assignment to ARRAY_SIZE(rss->ind_tbl), rebuilding and
rebooting produces the expected 0..7 repeating across all 256 entries.
A bidirectional multistream UDP test then increments multiple hardware
RX queues on both ports. Kernel configuration was unchanged. The corrected
kernel completed a subsequent repeated TCP/UDP bridge benchmark.

Runtime-tested source:
   repository: https://git.yoctoproject.org/linux-yocto
   branch: v6.18/standard/cn-sdkv6.12/octeon
   commit: 9a05f15b453377f50632ebbb57c87b7ec3270492
   source version: 6.18.52

This BSP kernel has additional local board/build compatibility changes.
The faulty assignment is also present in the unmodified BSP commit.

Source-only checks on 2026-09-25 also find the same assignment and array
declaration in torvalds/linux commit
aa98230e410f0ed212b6788c46b1e4d49e0ff7ca. I have not boot-tested that
upstream kernel, and have not established the first introducing commit.
The current Yocto BSP branch tip, 27016c83488643e42007ca7a2cfc1ad632f5ab57,
also still contains the faulty assignment (source check only).

The attached one-line patch is proposed for review. The diagnosis and patch
were prepared with AI assistance and validated on the physical device as
summarized above.

Thank you.

Best regards,

Jari Seppälä

--------------iMRlo67POggb8WRfMXMlOGf7
Content-Type: text/x-patch; charset=UTF-8; name="rss-table-size.patch"
Content-Disposition: attachment; filename="rss-table-size.patch"
Content-Transfer-Encoding: base64

LS0tIGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvbWFydmVsbC9vY3Rlb250eDIvbmljL290eDJf
Y29tbW9uLmMKKysrIGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvbWFydmVsbC9vY3Rlb250eDIv
bmljL290eDJfY29tbW9uLmMKQEAgLTM5NCw3ICszOTQsNyBAQAogCXN0cnVjdCBvdHgyX3Jz
c19pbmZvICpyc3MgPSAmcGZ2Zi0+aHcucnNzX2luZm87CiAJaW50IGlkeCwgcmV0ID0gMDsK
IAotCXJzcy0+cnNzX3NpemUgPSBzaXplb2YoKnJzcy0+aW5kX3RibCk7CisJcnNzLT5yc3Nf
c2l6ZSA9IEFSUkFZX1NJWkUocnNzLT5pbmRfdGJsKTsKIAogCS8qIEluaXQgUlNTIGtleSBp
ZiBpdCBpcyBub3Qgc2V0dXAgYWxyZWFkeSAqLwogCWlmICghcnNzLT5lbmFibGUpCg==

--------------iMRlo67POggb8WRfMXMlOGf7--
