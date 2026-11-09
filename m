Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.62.57.137
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794242471;
	b=vwqRLg5ow9spfrn9+coLYHD86cYXgy+0HYrWXkTMmemC7cQ/iUo9f7opeIYM6wrEiasp
	 kn5QSE1iX6J5TqVMsGpdCEk/XVxx+7bK9ItpEWQTCcB1YBALwm1negfvYCsUcv8LJMdnJ
	 qAWIPIw/d5QkFZpfOKEycSvM8AGY3uSDTMXMsLP94IjhBo3fcxznGR1fzYEFNKXwQBn/1
	 HgA+xhKTOM53zAaqcKpTD4nNfZ8vncI6xucxhUmUA75K3TOp5iiWnHSbkNbqCjMR2FruY
	 EpPkM/r71K0tqvuYRBH5c6rZLrlMivIttg2chuMll/ysm4pYfGDeSB8Hl2MpHXNo3cA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794242471;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=V+X7IEFTcG0ZrnplJcNIA2UecbDUOL9zjh/xRk24TaQ=;
	b=Fw8aXH19Yq9K7126lXZ71kby00tkzxWwEiCWkHU2GB7m+9yJq5gkPWkQbdlJN7svBTw3
	 wrML8IXBbshQIdnK2OE99V2cYitDwYU7Sn31PHH6eOaFnGAaRSoyFZW9tEc7i0nkvVWwC
	 K86wACNugbHqlb5XjfB0JCfARdz03wiLkKgstLRTLuPbUqfJfvUxH/jIY+FtJHoytH5QK
	 eMJcYtXqx2hKHIrGw80ix//9RcowikE7vxyalllcIMrn/g/1lo6sbSowy82YWra7TNcGQ
	 KCF8AmJFe3KuCHZvWDft5Lok1y8ov64e6H9yw1NDwYYUeoU1EXYri9/zfYSw6wQA8vg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=foxmail.com;
	spf=pass smtp.mailfrom=foxmail.com;
	dkim=pass header.d=foxmail.com header.i=@foxmail.com header.a=rsa-sha256 header.s=s201512 header.b=SlSm8EaO;
	arc=none smtp.remote-ip=162.62.57.137
Received: from out162-62-57-137.mail.qq.com (out162-62-57-137.mail.qq.com [162.62.57.137])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FD14606A31C
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 16:41:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6FD14606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=foxmail.com header.i=@foxmail.com header.a=rsa-sha256 header.s=s201512 header.b=SlSm8EaO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1794242464;
	bh=V+X7IEFTcG0ZrnplJcNIA2UecbDUOL9zjh/xRk24TaQ=;
	h=From:To:Cc:Subject:Date;
	b=SlSm8EaO+ufW+TrhRoO54Qn5oa8R1Hh+xuTv+BsS+BaL83GKQ8IeYvFYhTDoG0PCX
	 6ITXxUBu0WLuIBNrigO5BWIlq184OQaCDZxiJ1pHwc4CJm8bWP7eU1gkk7PdIeNK/4
	 Kd96O41CvivoBrh2drN3s1UiUBwIRxAPnHx12OP8=
Received: from localhost.localdomain ([183.23.108.92])
	by newxmesmtplogicsvrsza53-0.qq.com (NewEsmtp) with SMTP
	id A413CE3C; Tue, 10 Nov 2026 00:41:01 +0800
X-QQ-mid: xmsmtpt1794242461tm7ib9yvw
Message-ID: <tencent_6BAC076E552C6F338052FC02794D9B28ED0A@qq.com>
X-QQ-XMAILINFO: M/NR0wiIuy70ISTSzmCZ1jczkDN/6Vf0mJqpV7bfVQt1pUnVpABKDExRbOB51R
	 1T00JcHDfyc8Lqcjk/uNr92SI6aTxHF78RN/FI/KZnHE2R02BuC/YDLfcrgThPxTuY7XAo5HK/Uh
	 4DDPy1fNsml4v2rJ82KZ4DMgFE0cKblTcjN8G+5K3vIDfaXY+JFg+3QyEEZJva26BTmz2yXYTW3c
	 VP6AkeUuaGDzzYcG3vBoJQL/5LLoziidXT2+Rw+iBXZbIUpbrqqLFfr9Sb53lxL6/DGompT8FO3c
	 r/BwIKabPPp4k6pSksb2bX3F6H9s9roBWpbl0dMTZgDjyfFkqc4vWTk5bwVEoBwO2TSRfQReBoDV
	 h/kdFTpKUtuSlPeuBGLWfXVloToOVU3M3tAR6SxrxjJaS5KAJXRZYRGfx2nW8052xH0tdEOkknM6
	 5+S5WaGS5MRlrmEmzYD0+wuodiOSI5/b/C4Cw4rL6xmR8JdsZqBnBi0BfNwDsKijxdVSZVb37l1S
	 YRMrP4uf3yjYlaeNr0OzpXL0lJEUWtUVCsIoxMF73q+2DsbYvkvMZ/W49Np/V33uT3HZbUSu6DIi
	 eNMYC3ofhkmciJgxgJd6uOc5P4rE2pkqledzTumm4WdnvsSytoI4/HuYcA/bNba77r7+Myn2BYdE
	 03gv0qer+sIZ3kV5+73w4AWpxIGEPzSJ7J894bZyQi1bVjoJBokUozo7/4afilIXc0q5ObA5R1GN
	 zjc28Zpt0IDxzu1z+FrD5Wx8IC5Y3JTjj4r2V9uY9GBLCWdSqInhOrxd9SVHZ44e42ysw3e/8qLw
	 DED8IKkxW7tZ3CJCw1v4YQnD1XmMu+Ac0sTR2mqRIXGF4xpImRoumtjAok0aVJof7O6wGSjIQKcX
	 +Sqt3LsuBbJWepAN3++qRNZDA2/Gc3bDMXKQ/lZrgBz/2oU3C0DAMv1u4iXtVQkUwHM0MD09lDSN
	 bnDi1dI0qtFa9XrGRw+A89SqhRybKW+4Skrgg96bm9GlSueiYmTPBhPUStcvXx+smpDf1eVHV5gZ
	 CmOjw9f3LyMZR4hC7Zyvg6SA+VfOF0uG2IJUMRVB00dZ1ClyksYGq7vAZOhQTH66Fzuq7eINCVOi
	 2QdAPl
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
From: memoriaru@foxmail.com
To: netdev@vger.kernel.org
Cc: Steen.Hegelund@microchip.com,
	daniel.machon@microchip.com,
	UNGLinuxDriver@microchip.com,
	memoriaru@foxmail.com
Subject: [PATCH net v3 0/2] net: sparx5/lan969x: fix RX ring stall on frames from inactive ports
Date: Tue, 10 Nov 2026 00:40:58 +0800
X-OQ-MSGID: <20261109164100.8947-1-memoriaru@foxmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zhang Hewei <memoriaru@foxmail.com>

The FDMA RX path on both sparx5 and its lan969x sibling stalls the RX
ring forever when the hardware delivers a frame whose source port does
not map to an active netdev: the inactive-port error branch in both
drivers leaves the FDMA software cursor untouched, while the DCB keeps
its hardware DONE bit - so every following NAPI poll picks the same
DCB again and RX traffic stalls on all ports until the module is
reloaded.

Patch 1 treats a bogus frame on sparx5 as consumed (free the skb, clear
the array slot, return true). Patch 2 splits the two NULL meanings on
lan969x (allocation failure keeps its retry-later break; a bogus frame
returns ERR_PTR(-EINVAL)) and advances past it in the poll loop.

v3: address Daniel's review of v2 (pw-bot: cr) - drop the extraction
FIFO flush and the redundant comments, use dev_err_ratelimited()
instead of dev_err()/WARN_ON() (per Daniel's testing the splats slow
RX to a crawl), and drop the now-unneeded err.h include. No change to
the fix mechanics.

Found by code inspection; the stall needs the hardware to emit a frame
with an invalid source port, which cannot be triggered without hardware.
Review from someone with access to sparx5/lan969x systems would be
appreciated.


Zhang Hewei (2):
  net: sparx5: fix RX ring stall on frames from inactive ports
  net: lan969x: fix RX ring stall on frames from inactive ports

 .../microchip/sparx5/lan969x/lan969x_fdma.c     | 17 +++++++++++++++--
 .../net/ethernet/microchip/sparx5/sparx5_fdma.c |  8 +++++---
 2 files changed, 20 insertions(+), 5 deletions(-)

-- 
2.39.5 (Apple Git-154)

