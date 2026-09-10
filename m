Received: from mail.qrator.net (mx12.qrator.net [185.104.210.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE023DD51C
	for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 09:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.104.210.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789032087; cv=none; b=OjczHEWecjwnwgsCGYSgkVh67fHxrhQttjK17xoXGKmO3DkbQPt+AgJmM9qstjffOF9EqWrMPF+0mu5XBIFX/9sowCJogPXq7vxfaxWNwgAQUjT6rheIeMIRBWtZMQkrdGkYk+6U5g0Dm1reyZ7DUFMrnVuoFn36kNR9SsQjxcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789032087; c=relaxed/simple;
	bh=hftO2mhQwI730gPMHPzUqasS6kTYVRwic2VNQHIOnqA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T7Mn7cIytItBEMpKzSgf1UMM4cKwGhEJV3tEfmfMZYjRC5UEeCOOJLcjHog9aiENaGNwHipK/7JMdTQfkOHRW+C1U+I0GyyNHFtugvqFuz8eFeBdnihOX3MBz8Ltg40T7x6h0Texn1DgBzKvkEnw/ueFxADtb5coQe2V6yFJhRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qrator.net; spf=pass smtp.mailfrom=qrator.net; dkim=pass (2048-bit key) header.d=qrator.net header.i=@qrator.net header.b=iPtsUrTp; arc=none smtp.client-ip=185.104.210.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qrator.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qrator.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qrator.net header.i=@qrator.net header.b="iPtsUrTp"
Received: from mail.router (mail-postfixrouter-1.mail_default [10.0.5.10])
	by mail.qrator.net (Postfix) with ESMTP id AF2D96B28AC4;
	Thu, 10 Sep 2026 09:21:17 +0000 (UTC)
Received: from enterprise.localdomain (unknown [10.0.5.1])
	by mail.router (Postfix) with ESMTP id 7F2E46B28AAD;
	Thu, 10 Sep 2026 09:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=qrator.net; s=mx12;
	t=1789032077; bh=hftO2mhQwI730gPMHPzUqasS6kTYVRwic2VNQHIOnqA=;
	h=From:To:Cc:Subject:Date;
	b=iPtsUrTpnIW27Q8SIdTQ1NbdkYtnB9tZZ7j7dc1q/2voRsP9DZb+5rD7CmVFm19Z+
	 eYj2PH0gZZtXDQ8kxyE49V4SpV/aFg1QVEz+ZILCZ7g5qq5dlyVAkxaP120lvm2Lay
	 GyqUJNov/TE/HoWB2z65cjAJ8PsIJECPIw0PjoMQWoyisi7Qk7ly1IQcl4uZByAKcP
	 XxZUJqQEu6iGNqyn8FWjoeEzwmSAevSBD8BqbD5dpXI9xufbmXCCZ+91y+i96KFuVz
	 NpHI9pFM4lAZ2mzW8MnKGV+vtL74I3mkNz2jeatUxVAzdtX336MClt+S+Z18InXGph
	 EEkScYDHXahww==
Received: from localhost.localdomain (localhost [127.0.0.1])
	by enterprise.localdomain (Postfix) with ESMTP id B4233B400944;
	Thu, 10 Sep 2026 09:21:16 +0000 (UTC)
From: Alexander Zubkov <green@qrator.net>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	Petr Machata <me@pmachata.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Alexander Zubkov <green@qrator.net>
Subject: [PATCH iproute2 v3 0/2] ip: ipstats: Fix statistics split across netlink messages
Date: Thu, 10 Sep 2026 11:20:55 +0200
Message-ID: <20260910092057.3980-1-green@qrator.net>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The kernel can split the statistics of one interface across several
netlink messages, and "ip stats" formats each of them on its own, so the
interface is shown twice and part of its statistics is lost. Easy to hit
with "group offload subgroup l3_stats" on a box with many netdevices:

    109: vlan859: group offload subgroup l3_stats on used on

    109: vlan859: group offload subgroup l3_stats

Patch 1 merges such messages before formatting them, patch 2 is an
unrelated cleanup.

v3:
 - Merge rewritten to the shape Stephen suggested.
v2: https://lore.kernel.org/netdev/20260908181225.31712-1-green@qrator.net/
 - Comments and commit messages trimmed, the merge reworked around the
   two border attributes that can actually be halves of one nest.
v1: https://lore.kernel.org/netdev/20260830181949.1096-1-green@qrator.net/

Alexander Zubkov (2):
  ip: ipstats: Merge statistics split across several netlink messages
  ip: ipstats: Do not hide HW statistics when hw_stats_info is missing

 ip/ipstats.c | 145 ++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 137 insertions(+), 8 deletions(-)

-- 
2.55.0

