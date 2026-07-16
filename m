Received: from outbound.ms.icloud.com (ms-2001d-snip4-2.eps.apple.com [57.103.73.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0064E38F934
	for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 20:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.73.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784234329; cv=none; b=B+t34IjGpbPsrShShASzyN3MV6tf2ShATNmq3Oah1i7or8Sz8ZeHkg8eQoIrDRNff+rYLs99Y4HXOUkGq2RGr+b4Z5sozWRL3aAUN7AUn8+fHWtlBrCaA92sRFmuSgWRAU8E+UDdHS0NXs9iouJF2V5eey+yUe167xq8jjcqyqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784234329; c=relaxed/simple;
	bh=8dk4SeVyd/X+HwM8UCU9I8OLQ2e4wTy03ZREsV8NFjI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sTWudfSPKmZtWxXJQGt2z+p0qYp6Tpo6uSrvM1VrmTtjRlaGRggXeS26pY4//lui+TO4+QlnwE/94gYb32wKoZ1aqR/RZsEfILj2H78hUXaVYpVTyIUx24uFmZ9v3T4Y9kZ8TcQ7vyMnkqGSJSIXmgrQ8NDTcTBAw0hFQBPZzFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=jX+ceZyC; arc=none smtp.client-ip=57.103.73.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="jX+ceZyC"
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-west-3a-60-percent-9 (Postfix) with ESMTPS id 05B391800117;
	Thu, 16 Jul 2026 20:38:44 +0000 (UTC)
X-ICL-RepId: 019f6ca7-33ec-7c2a-bb35-343fb7ebbe27
X-ICL-Out-Info: HUtFAUMEWwJACUgBTUQeDx5WFlZNRAJCTQ1OHVQORQBEF0kDXRcOVk1KFlwaQAdTG1w4Wg5bBEcUFxtcABcNVk1QG18CQg8cE1YVEx9UVgNBGRBWAVhWXQVNGlwYWQ8cHUpWWg5bBEcUFxtcABcbRgIEIwJfAEUCXglWATAXD1ZNUBtfAkIPHBNWFRMAXg8PTAtIAVsHXANGC0gAWAdcHEcKSgtABkZBHlYPRAFWAFcwUBtfAkIPHBNWFQ1NQxJCFQQRUAFYHlY=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; t=1784234327; x=1786826327; bh=M02iASs7Ytws1bpLPc+7UurQGgw9o60ho8uuBszePNg=; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme; b=jX+ceZyCqaITXhdZTbFIvJ9Y4TVdyOYMnabGw5nyS7IMPH1hUkLCuaA2ucXAs/3s5x+U+5ltBxC3AFtUgYcP1gX2nXlRsZ8FOwiq0uDr2tnTY9eue1+V3JkZYHc4GrX61ddKkL9kKmusF1YPf7mOkOGetk46y5Dy4VNzQrQZRyu0iEHTXK2EB6HMIvZYQ7aG3KO3USWSqRoWoLnr/SICOhKIpRpfikGg+De7geAWuh3GbZ4/Su6MRQXyyDvKWj1uXezHVN3d86DZfhtuouk9BLJYlqx31vyjDKosVh+9c8nzOdc97zkyw06t3+ujjnwE68BZPj5YGRoJWrrlph+2EQ==
Received: from mainframe.tailfb0f7b.ts.net (unknown [17.57.154.37])
	by p00-icloudmta-asmtp-us-west-3a-60-percent-9 (Postfix) with ESMTPSA id 36B551800112;
	Thu, 16 Jul 2026 20:38:42 +0000 (UTC)
From: =?UTF-8?q?Lek=C3=AB=20Hap=C3=A7iu?= <snowwlake@icloud.com>
To: David Heidelberg <david+nfc@ixit.cz>
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	krzk@kernel.org,
	horms@kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	oe-linux-nfc@lists.linux.dev,
	=?UTF-8?q?Lek=C3=AB=20Hap=C3=A7iu?= <snowwlake@icloud.com>
Subject: [PATCH net v5 0/3] nfc: fix remaining OOB bugs in NCI/LLCP parsing
Date: Thu, 16 Jul 2026 22:35:04 +0200
Message-ID: <20260716203507.7328-1-snowwlake@icloud.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: wAm5HlmW9IUjJCJOUf6Z3H1GPdWt4oef
X-Proofpoint-GUID: wAm5HlmW9IUjJCJOUf6Z3H1GPdWt4oef
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDIxMSBTYWx0ZWRfX2N2rk7UQD0DA
 X+fSJZlg4VR1pDN/cH15fBhjmfVsXifdNluSmC4Z9xVQ927SzeyK+76O1D4aZa88nQSB3QtQcQj
 lV7WeRTbhjhr9+5K7ciEqPIkJLtaervATliZP3sxg5wrosqK7Cw15xKK9f6YJvcvbFP49PA1XkQ
 s0EgiHonKLrvYR9ZW0Yzw13gPh7paRXs/zEyBupzYgTPD4Jw3asPeXtSRnHEnrHFh2hqDum3KhN
 jk4U/NBXXdFSMjcGe2QAhmD+R5g+yFHh8CT8kbqfJ0lbfDtoi+fPb2/J1OVkbJGmNdjsZMhcsnF
 DK5nWkWkQkaiY75mD9G

Rebased against David's linux-nfc for-linus tree [1], as requested.

This was originally a 5-patch series. Two of the five (the
parse_gb_tlv()/parse_connection_tlv() offset-wrap fix and the
nfc_llcp_recv_snl() TLV bounds fix) have since been fixed independently
by other contributors already merged into for-linus:

  d8bd2dedbde5 ("nfc: llcp: fix OOB read and u8 offset wrap in TLV parsers")
  27256cdb290e ("nfc: llcp: bound SNL TLV parsing to the skb and add length checks")

Those two are dropped from this series to avoid duplicating work. The
remaining three patches are unchanged in substance from v4, just
rebased and renumbered:

  1/3 (was 1/5) - nci_store_general_bytes_nfc_dep() u8 underflow
  2/3 (was 4/5) - nfc_llcp_recv_dm() OOB read of the reason byte
  3/3 (was 5/5) - nfc_llcp_connect_sn() TLV parsing OOB

All three still reproduce against current for-linus (verified against
1671b8fb7300 before rebase). checkpatch --strict is clean on all three.

[1] https://codeberg.org/linux-nfc/linux.git for-linus

Lekë Hapçiu (3):
  nfc: nci: fix u8 underflow in nci_store_general_bytes_nfc_dep
  nfc: llcp: fix OOB read of DM reason byte in nfc_llcp_recv_dm
  nfc: llcp: fix TLV parsing OOB in nfc_llcp_connect_sn

 net/nfc/llcp_core.c | 19 +++++++++++++++++--
 net/nfc/nci/ntf.c   |  6 ++++++
 2 files changed, 23 insertions(+), 2 deletions(-)

-- 
2.51.0

