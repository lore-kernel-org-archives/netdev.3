Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794232316;
	b=4FixGchqbQYYlKq9mZiCnZS3BqutAmr3txzr3Cv4wrc7uniYZkKI2bmKq9osauWACa1v
	 hPxEj+HS6bbcPA8Qo3L0PHY1/BV+QbDBpEovI2cg8S5MsREeoFRR38/fD0QIa4r/QIT9j
	 VhIN1QrZUlpPpAtVQEEji/oA330wyPoUKxPRN8T3TzyjQ9DWtz5Nes1UCqizLH/eezLcq
	 pQie7MI8nU0mUazkUIIGOniXW94zFga6/1CG7bfOuI5Q3bzKluvINtk6pP/TNlpWMpDRg
	 t501lRbTYzjUS8YciohyYDHQLRGcrHKpHkS89n7tAMnRQ4SiB8nDn6WCsSBYDZHQ22w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794232316;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=80POjU5WP6ctS0DqN7hA/63JAQ8Agh1hTny2C1kJcvk=;
	b=NHlwNJomZxmHPeUJkNg02c5axupBN/VAlSgaylrfTxXK1Dd9/rKTRyqSOgSTPFN54iUS
	 CwjsrVVKc6WuayM9V8ctuPrQSkoeYtquaITxvxrAe+W9aDBu66eLdGMoCJXV8Cuqdb2Zi
	 owhbUhtTMQtlySVIShaozliNDNsu720dgDdxW2LIHeJCU1+n+BMjdaxdEJqsR/xrNgVp+
	 CguCLHsz3t2URkux6wZWqWW//0vmu3tlkv1l9uBEYzqNtGrN6JT3NVfVqlX9bQLoQRa93
	 hsbxSE1kcXI8lYc5G9D4XJZ4thbeWdDmX5/JM9mECmx2dQxIbBjJA1GAOFh38n6b7Tw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GQiPFmW+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD5B606A31C;
	Mon,  9 Nov 2026 13:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GQiPFmW+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17FFA1F0089F;
	Mon,  9 Nov 2026 13:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794232316;
	bh=80POjU5WP6ctS0DqN7hA/63JAQ8Agh1hTny2C1kJcvk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GQiPFmW++teWC8tPA6X1ymadkaWaj74H8EKRoAoRibqzy8L2fYvxXc1sTJaJA9Ryn
	 VNtjGuscac9u2OwVnkIm/9fS8J+7W5bqziG0begA1S62YduwlwXEP63AYgtccCndwM
	 gpxIeCTjj0BISMirStSHczAV7cpqwTrkBnzJnNKidTy/Jjd9ixgIhnq0SllY+++6qC
	 B/0haJiKvMxH4cJCbGquq+BZ6DRyfwjDdO2zNxE8TXD6zkwx49GQv0ApMMFs237jfc
	 AA+mXVBFCIVpOj+hMTG/cYZ4vT+iIVpI4aDckLNRoliWlCwl4umpkVbB2wdJkwRt8e
	 yc38uE/Tckuag==
From: netdev-bot+sinfo@kernel.org
To: Zxyan Zhu <zxyan0222@gmail.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, maxime.chevallier@bootlin.com,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 richardcochran@gmail.com, muhammad.nazim.amirul.nazle.asmade@altera.com,
 rohan.g.thomas@altera.com, rmk+kernel@armlinux.org.uk,
 o.rempel@pengutronix.de, wojciech.drewek@intel.com, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v10 0/3] net: stmmac: dwxgmac2: timestamp
 interrupt support + Agilex5 fix
Date: Mon, 09 Nov 2026 13:51:54 +0000
Message-ID: <179423231463.488859.16977464890948797360@kernel.org>
In-Reply-To: <20261109134506.2794160-1-zxyan0222@gmail.com>
References: <20261109134506.2794160-1-zxyan0222@gmail.com>
Auto-Submitted: auto-generated
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi!

This is an automated message. This series looks like a fix, but its
commit messages seem to be missing some information:

 - What hardware the change was tested on. For driver fixes please
   mention the device (and if relevant firmware version) used for
   testing, or say that the change was not tested on real hardware.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
