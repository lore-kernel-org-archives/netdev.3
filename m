Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793907287;
	b=0Ajqqvl2K/87144lTBX+NBybviRFMQUkePVeWnUlo/u4CE+SbeYLyrx3RD4YygRbuy/P
	 HSfbdp33wYOHBNe6jxO2CpIg4Kvw32DmlLJT+xSju2XZUoW5/8ny67zcUBuSdwj51aTdw
	 b0Cf6hNnGJQ8FaipcLHmp9jWRnlYG8MJzIn5Ib4JwUxbjB/w1zP3rje/Hea8Pjhj6MD5L
	 8b+6rXL7xq4N/Y6KE8mm+PymNZVPgOp3nx3aD9SmpJ7MWRJbePzDhjWV7/pUDvmvxFVHo
	 qXgU/2dg/dXObUAFmeFa7neUk86djXVhyeb9UCAQkMe1aeWGZiGjNv3i+HT4CJ0ghCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793907287;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=Svx2OB+5F/Y9K9wuzVYoysQj3wgGVFkM/gP/phcnBkc=;
	b=YSaLN4RyZja8Uj4surh+nFEGiOqnuv7Z/USDhd60U6xuVzHKdvpmK/G+Ank8ytMN4LTp
	 eS8ABeSkLJgbp4Tygug50MIl8HjNR4L6SNrBigaU9Z4lE4KCUqWUQ4Zc9n+j9EO67i4me
	 MvwENRVazAw6ggxM0L5xqylH6mrIafPaaC4xJFJjfcBkZcSZG76FXhZGVcOG7Vwh0Vw6Q
	 81EKgR5UBwGyMdmjnOGFQRWqygPwyfiK+nf3mRnypbaHrq+hXq5UUvyUBqTOCt4+/T/SL
	 2HvYtniC7QTzEZVh0oawkk7v/TEJpiz7tW9o6eQx/IqF1/bQbsNbWnf5nhHGN8d1s8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xfLzh0l2;
	arc=none smtp.remote-ip=74.125.82.54
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0666C6072C61
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 19:34:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0666C6072C61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xfLzh0l2
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-1b1ce85287aso2038340c88.0
        for <netdev@vger.kernel.org>; Thu, 05 Nov 2026 11:34:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793907286; x=1794512086; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Svx2OB+5F/Y9K9wuzVYoysQj3wgGVFkM/gP/phcnBkc=;
        b=xfLzh0l2vsCqCCdPQRfMs1ZN4FSXDvC+ZpFAda9llXVG46mE0arY6MvudKimUQHZJX
         5VDvlM2X6G2oGV15e4gxJkHk9m3LBdq3i7GpwUCgIfyCsL7aivloXlQ2+xLPF+sVvAUY
         KQdu9UK1zX9asOCqCsQngZeOElDrLw2C/kiXW49mGECA2/uwIcmMQS3jSp15FAQlcqy6
         VqJ0uhGBNvqesROQK2Rg4AOTtwUxyON4ZzbibkinXYgG7N0wQbl9BCGaF/YIL6osVxlC
         hd2HRWRNWJF4USO791FelnXoH3ikp7Kul4PMG2A9VREKPYUYR7xullxIOixCTL5qT9vB
         QfDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793907286; x=1794512086;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Svx2OB+5F/Y9K9wuzVYoysQj3wgGVFkM/gP/phcnBkc=;
        b=fISL3MDNYgeUSioqlMCqAEpmY2H7d4v1v+SuLwa9rQVGNRD0u9m4gNuS8buuktg3c2
         h13N8LOwF7/4vXOYDfkZN+VSS2M/3L0zkhlJ0UGVuQz8F212HY69tC7Nn2zYYI4toYUn
         wabbpq9gO5Z1rUXx8QBy33CdhrF1xZtiqPwfCCULFuWuLBDHUV39xFRHO7nHtmfJIM/B
         fVV/U75WxbhB4I7BlUS73rANhSb+FM9Vzw3OIYEUAsAFh5jTB/oqaRLI7aw/Rlsi6rQe
         cbaY8n/UjtTVsQb24pNbmJJ7Kj0tULp/+5dyXxShWjZp9doXnB+Bkz+RPce1JeBblm1w
         T3pA==
X-Gm-Message-State: APuU4Z9yXU9QG0NmzVm1m5GGMzSEpUA8YBbDkZj1LFnZkDdM2VrZpTOk
	YSzea+Csgw77BAnKIC/Pz30/xrQ0RabMjckySFXVy9/szvV/RfIC5pl1mKEZ7g==
X-Gm-Gg: AYBFou2fbCciC8KVaq9LbK6LSNgq3jc5GIORfEYyreP6aa5kKLkbBT0MoHgrE7A2GvJ
	W64DXwPz2Ue+7AHCbCFGioVZb6Cdo1AfuqUcY7hCTULoBzMOUQcJyp6s6cV3YXZ5fGA7llJbKdD
	v1TESQdMvlQpzSDwS5KdDplskn2gytWzQGtr8uBa8Dbd8MoU0WgsdPHj4B7HPa8OLXSJ1R6TPP6
	B0x1jFMn61oSZorj/pwUqCVkO8CvahM7EOwwk5mxscEcTusNX6QFAxu+W+pT4/yfMeSP8ifkldj
	unWMYuO6XVoyq//I6hPkrzdJbxevP7gyzsXeQkQKXh4TCPFAv56Hf/F0rHtzaU9BQt9CJ2K9xAa
	dZxS+FJwaPB0tSzqyc4ziwQ2G9dPnLcAAt7usVEVi1i724r4Oe3rsrgB3Fk6LVxCglBZzt1foEA
	POUWZYpKWgqiaWM3+6iyXNEtUYHSI0pzmoqz39xY6bLl4ylOyJXOShtFqQyYFyjwTuqeoB8OWNU
	Z0uH/t/azvWt9PSAkvntRPfnQYmHFeM9EW0a4pjHucU5XEhwyCoYTqEr+fnDxoEXn5rfnu5sp3u
	WRoHqEVXNEW/OAOVxcdX08m5IAacT/M=
X-Received: by 2002:a05:701b:42c3:20b0:1b2:366a:e7d1 with SMTP id a92af1059eb24-1b2366ae854mr16753451c88.32.1793907285921;
        Thu, 05 Nov 2026 11:34:45 -0800 (PST)
Received: from eldorado ([2600:8802:b00:1f88::287])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b245c1c127sm18023186c88.6.2026.11.05.11.34.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 11:34:43 -0800 (PST)
From: Florian Fainelli <f.fainelli@gmail.com>
To: netdev@vger.kernel.org
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org (open list),
	macro@orcam.me.uk
Subject: [PATCH net-next 0/3]: net: sb1250-mac: ethtool link updates
Date: Thu,  5 Nov 2026 11:34:32 -0800
Message-ID: <20261105193435.2050321-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.53.0
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

This patch series addresses a few minor issues:

- Running ethtool against an sb1250-mac backed interface would not
  return any link information, although all of it is there
- There was no support for restarting auto-negotiation, also there for
  "free" with PHYLIB
- The kernel driver reports enabling RX Checksum offload but does not
  report it through the NETIF_F_* feature bits

Florian Fainelli (3):
  net: sb1250-mac: Add ethtool link settings support
  net: sb1250-mac: Advertise and honor RX checksum offload
  net: sb1250-mac: Add ethtool autonegotiation restart support

 drivers/net/ethernet/broadcom/sb1250-mac.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

-- 
2.53.0

