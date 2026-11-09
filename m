Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=43.163.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794211387;
	b=N+EWxw+0NJOJGCkiqee5J2E+hxaKFyuwOZ6v9sX1WMd7L93m2hV36qECqCg0dOkK4onR
	 4aXrpuT/1LuGRvLSAopQAmFbn5Sofsgu/FhaPUHlbTvc+ibk4LqzKR6LQZ3vbUA8gWdCC
	 MU+rhd85337b+SIru9R/zLqc46jaWPlrwPAhbrZoH4IQ4Chj2rZFeux/RAMxnzJOtlzDr
	 iDdxVv7lZMnJTmKyBq1IOnpe+shi0G5ejfMC0ZKfZycCtpfiY/aIdvdwzjzhDJTi0f7oN
	 Y98We6a/zo3nnzupIUNwjl4cF/XeRGoiq5V0BfSGik70Y77GMSeJPygDkY1oqeLs0cg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794211387;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=Z/rHRhLXImGPKv4aC0q+JHvXgEG0/LvKco7wF+nbZOw=;
	b=IKqlC0jAa0p5nmkwm9LXHATnbDuueYVi3z41NYSct/RTh/Dqy3gTTIRgyTjqcRWHWS9G
	 C4DRuaZ28STr4rB7e5utJxZfdY6gNrL7nr8pUezuORhtPz5u8Su/80uIxjmBj4DYPB8yI
	 no3ufR+Q6cf7tbrV8RvGXR8cH/uDsVIJpkwun4pDQH713k5LwGEX8y1Vpkh0vJNHvOHzL
	 KtO4hSHoCB1OlYdARGcznDtlWX6xdx/IGc20fBz9gM1a+pWXqdrUcltiNfUkSNuZO9MGy
	 g7nTgXUgq7xpG2SJp0R37KeH8+TGJ3m2ytlB/2foGz3udap0WZK9a8aRRLZr0f0KUvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=foxmail.com;
	spf=pass smtp.mailfrom=foxmail.com;
	dkim=pass header.d=foxmail.com header.i=@foxmail.com header.a=rsa-sha256 header.s=s201512 header.b=jQwfe26A;
	arc=none smtp.remote-ip=43.163.128.43
Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.43])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6728606A31C
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 08:03:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D6728606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=foxmail.com header.i=@foxmail.com header.a=rsa-sha256 header.s=s201512 header.b=jQwfe26A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1794211377;
	bh=Z/rHRhLXImGPKv4aC0q+JHvXgEG0/LvKco7wF+nbZOw=;
	h=From:To:Cc:Subject:Date;
	b=jQwfe26A9PzxBwHtFpkayoL1UWxH+yd9y5L63rfXBCHsJG7+u+dR5benk6r1Bswux
	 ZRPoOKMfK4z+eYQcDY+Bmarq1dYFhvddJResSacxKv3ihBiZ0ofLtnWo4rP8aHb5nY
	 MN04jndbZpS8MCvxs9t4Q0aHJAb0RXdRQtG1F1a8=
Received: from localhost.localdomain ([183.23.108.92])
	by newxmesmtplogicsvrszb43-0.qq.com (NewEsmtp) with SMTP
	id B79240B; Mon, 09 Nov 2026 16:02:55 +0800
X-QQ-mid: xmsmtpt1794211375te3kv8cp3
Message-ID: <tencent_E018A629F0808AA68194ECD60FB6B096BD09@qq.com>
X-QQ-XMAILINFO: NGZp1yYNf7Y+Tx1mgzTvMLegNet/UE90JHwikH3aBcSKgSUr4S8dNNiWJmAkNS
	 1mUXPkxDdiwJV/L8mgdXpI++hgLRfP2CKDCLX6Y6rCRtDdWU5rJ1svTDFvqyOoffL1ucsgKbj+8I
	 AxBDRMKWUsZFEd3d8+JIHCKz3AcS7s6/9eKB3E/zVMwMH9VTS1osjFimLVN7KZw0lIth/nBlNSH0
	 3SK7DHsU75ziCl9fWdcFIbGGNSAjnBwRX2nkhirBX1O9JKP+5uwR/KwXcvqC4Fuc2IZ85rDVqaPq
	 0SVXcfRjNttnljm8PNu6G32EvmWllvXRNhZlggf564VriWs4tpPG4m9h/+5EjkpDUgIAh45Btpj6
	 1oPDXSLrSFImWJxwctTmQscF+sgWu0aCLfv9EoMVOdDv2GAN/9X+bIeeBpB/1cU9Pf0vlRTsrvLz
	 xeYVuCfuwUfcXteGEjCvrfIm/IViqrkeQuW6HftY2hHgwlhD6hTXmU2tRPAla5BbDjVO4TMrlflC
	 sgHFNMEEbugwISF/4vedV30isurjQhmH1v38ddNiE61i0vfhkeyoYyoswNnd4R3SCEY4AR33Zt6p
	 Wmv2O/5Kkr+eNjJsRxUfmWtQemaygFVOWRO7tMaVFOv7tuZ0oVPNVMB8N1jKhVEoKzScyB5ZJEN3
	 ZEDir+4UzYxsvI7rs88vJw+G/Qja7zT/JE4pRh5SGO7oaHuMz+q+NYrzy+wXaSw5BQ8lM6Q9k659
	 QtHcHfG74kkukR6GXRmJDYRZnrLEAy2RcMKQ9QofQjB89qwINiho+NBmkClSaqX/I3NhVbfGx/y/
	 YSGbiy+qPkQ6wNSTCItHJwxkF0v6TAM61cDU3ezd3KZ4gfoFGjDTSgeN38u8gGlB8i4HgIwuWIGg
	 hhOmBuKG7SYea1azNVI2FDE0Vl5NLCkWLzv9o4mJcUedm7HfnOBInH9YcuT6A0pT8MQSDMX+IT8t
	 WAVS1gaTptg+McpDNJerSRqeoPqlSWZLjIgtGCQLeG52BQ1PL2KQ2EZ1uuzP+r5JsZKjYLsN+kqC
	 645mlkizJyhr0o6rPsXZxPytGrqCs7Fd0jah4YZVcB86LJkWMvMr79MMjZHSNqFTMuWWPDTq0Mg4
	 ozhf+M1dq1PRZ3jJI=
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
From: memoriaru@foxmail.com
To: netdev@vger.kernel.org
Cc: Steen.Hegelund@microchip.com,
	daniel.machon@microchip.com,
	UNGLinuxDriver@microchip.com,
	memoriaru@foxmail.com
Subject: [PATCH net v2 0/2] net: sparx5/lan969x: fix RX ring stall on frames from inactive ports
Date: Mon,  9 Nov 2026 16:02:52 +0800
X-OQ-MSGID: <20261109080254.92305-1-memoriaru@foxmail.com>
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
reloaded. sparx5_xtr_flush() only drains the QS_XTR hardware FIFO and
does not clear the stall.

Patch 1 treats a bogus frame on sparx5 as consumed (free the skb, clear
the array slot, return true). Patch 2 splits the two NULL meanings on
lan969x (allocation failure keeps its retry-later break; a bogus frame
returns ERR_PTR(-EINVAL)) and advances past it in the poll loop.

v2: hand-assembled v1 mails were mangled (duplicated newlines, missing
diff headers, broken threading) and used a non-answerable From/SoB
address - apologies. Regenerated with git format-patch; same two fixes,
no functional change. v1 lore link:
https://lore.kernel.org/netdev/20261108184541.74618-1-memoriaru@foxmail.com/

Found by code inspection; the stall needs the hardware to emit a frame
with an invalid source port, which cannot be triggered without hardware.
Review from someone with access to sparx5/lan969x systems would be
appreciated.


Zhang Hewei (2):
  net: sparx5: fix RX ring stall on frames from inactive ports
  net: lan969x: fix RX ring stall on frames from inactive ports

 .../microchip/sparx5/lan969x/lan969x_fdma.c   | 24 +++++++++++++++++--
 .../ethernet/microchip/sparx5/sparx5_fdma.c   |  9 ++++++-
 2 files changed, 30 insertions(+), 3 deletions(-)

-- 
2.39.5 (Apple Git-154)

