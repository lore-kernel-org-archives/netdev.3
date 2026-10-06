Received: from sonic308-17.consmr.mail.ir2.yahoo.com (sonic308-17.consmr.mail.ir2.yahoo.com [77.238.178.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B6537F8CC
	for <netdev@vger.kernel.org>; Tue,  6 Oct 2026 11:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.238.178.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791286811; cv=none; b=mqjLvEQGfgQh/0A3Sa25iC4BSUGXQLP2Uj8I3quytPSwicaurryvXHBULR0j1ZqZFOsAHu++IrrllHKxfzLgYq6Spxdyhgfq/j87KDgrhGi/w/jSL1Cc9dWyv1SFFLJ8JuZ5h2RORp89BBNJ2LHS2NU8MrfmRd4ZbV/Ai82afv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791286811; c=relaxed/simple;
	bh=wkm3SWGC9/4bBpG8ZcWuwHfvayB7mVGlCBRNoLHww10=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=VbGawpPE41il9lCd52oCrZcbzYo2+Jp7dp1h9PRlCvhy8i5mwPqTmHI/k4E7OZpJwi0pKlu45wZuTv7/59bniGAK3/zzEGsK96cXeXV1xZxe5c07cIgFPiKXhRZ8fdGSHJ6JwCGybfCXJsg7aQPRA4L6YZ5suOFAHM8y/YF1KXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ymail.com; spf=pass smtp.mailfrom=ymail.com; dkim=pass (2048-bit key) header.d=ymail.com header.i=@ymail.com header.b=WNRHxkTJ; arc=none smtp.client-ip=77.238.178.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ymail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ymail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ymail.com header.i=@ymail.com header.b="WNRHxkTJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ymail.com; s=s2048; t=1791286808; bh=HIlrYJk6Xp4PvfFizQJ+RZO9Wa0gJ9XH2BbBIPwGi9o=; h=Date:From:To:Cc:In-Reply-To:References:Subject:From:Subject:Reply-To; b=WNRHxkTJO5BK9IQwCYDH2VF5vvYZ85fWFElazOD/AFn1qUmEzi/ZkSO+j56GvYElmfFlGU/jCq2wqrqYLaLh+ir1Mgx90IWLt+S8kAL4gtAAZ4rF9Mz1QlACE0+RWBkOjtV51AnBWP1TXDYnqPlp8bjQ7vFGAklDLulBRGuSc3zTiscaUMfX2x+tqOib6WX7szUscigGkLQfMyzODfRXRC54c+dOR412k1NaQh95XPsHaJpXfmUfjkWkanqXUv+6j4MK3w9SiSZ6eNQd/Coai2B3UTFD4fYzAd9RfXjO+V+TIKZXcBTUwIVfxKXbH+SKfqMv71doFa5axWdEebFulQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1791286808; bh=bhW5ec7Yklvft7opOm7uJIIAFg2KGWt7jPaALyDSmi9=; h=X-Sonic-MF:Date:From:To:Subject:From:Subject; b=bEEYJ0eVQHGsPnzYj+XO8Zyp2OVIC+FKfiAZrLhfr836vUgtaWRJz2nMTbzzLYhY5mLptlXE8vEonLTPUCrTETdijUZTWp+AJABR3o/xnIpn9WEyJlByGjq4TuLMR9fl8O5WBoJuNdahv4EpRCxRJWbuaKiQDL8MsE1jGA5qPVe2c1BsZ4GYK2a8lMyV3wbaHVuNPbGS6LnDxQM9YittyqnJWqb/F2k/ZdaVdCh43jNco0GW2IXyLj4x/Ox66w0v7xLfQw0r90BRFy9934akDTTuEDJPpurP3S6F/eFVpUPmwNpDD6auVBBtxSJQ09Ag28o4ZaeHYC2DtxpN17zEfQ==
X-YMail-OSG: aGha6zIVM1lFnu.YNireiwrQgAIe4qw_HRCeK4GMDb3Zb.Po2fBbAxu7K9CQbgb
 zRNNZDpwVXIQWZ.eZnTQI1qjwfq.koBVDYtSyAc7rqt2xoGdT.V9GQJiH.tBCaWOvyc9Fp14N6VP
 g89Ob3isUj5wMeu.45Ld3n4mwCLaftzaDSLj28veTw_F2zlTavjHMLmz0gIWmcXIbsx34ZY8CymO
 6l5NXCDduT0dmMRgjyYX013MnDmZt27iowO2dMt719JoMC_UfIjMTW8fnoUz6oTnHAacO8XoE.Dj
 NG0IMgtEIxhxRrXOKCwTWvuTa09Q6cycsTgoMzhU4eNB3YxHar80nlc7oia21vOJPNuR4rHC6E6y
 yRok13sx3.u.fCp74t4mxQ9JviYjJSduyu6Y5rANF9ngJMo3M9SKmVERN.fzwb9gr8DjdBXcLnvM
 cLtC6ioxQdl.sQ.gpeCkFM.b9yG03bYjXzh.Tqu8Hu2ANRhpNg.B8iMPvNqhXMcyXonS5WmyP53M
 pZusxAy_aKmdqhHcjfjqMitw0T7MSXsRSqL441ntv97rT1Qv0tke_A1tvlH2VfYzh5AQDG1IrDsR
 azm4IJjrHUT.Ffd5P7DIIsv_5p45CWuengwa9uQ2sY0QqzQw6OJJ7X2M48vc65BRod6U6dnfTEmk
 JJJ763qfwjGiRbF5RFH6MIMRixSX4YEtnHoG7OxL7QDPxo5OH_5YI4WY_SIHl0KjFveSbkuN3VzZ
 uyjzsBh29vA5_A2Ege5.3ng10DVXPRnjAAgkFjcXBOGZshQwZwjbhYmAuQIkKEsCgo8ssE8z4QbB
 rnFKsGAgyYJkzshj5PpERxP6T1POKanwOWOWlRX3qSftSIzWnCQrRnUvsDy9ZauIeXnZw4Hjei8U
 Jq6M7g7tO6lSOsxw1t23BoCoUzb5yL7.jDj9HL7ME7Lj5CgaL3miGNpcBSBcRnzUNXbutVtH.dSK
 NO5oPMoYgiENTitycvQLFniZe.YvHvtFVMw9kRqAWlaXEyE_Gt_1WslqKW6CxizIh39nCN5_KPVA
 M8cDFAe162rWyEm60BomfVXPIhy381lsfVU65G14kV_ThOOs00VJFIg1GOqd0WmAjK2rB.x9kNwn
 7yA1AAaB2sMXb09NuF_b3ZKe7vdT04NqPlXjSW7OI7imXpBXoi37.oGuKjD6PZlzWcS18s475XUn
 jyThA8BcMltEs4aASPL0.KthOGu0CBFSOmGmUXVlKu1EKEOYj0..9ItlIKmR66XMUJ_tfjQKQM5Q
 oO8rshc6SQczBAJ4.sOLpvOx0d8AH7ub4FMq7cW755UIw5_jASu8oaQ128SYmvP84ouJQkW3NgkB
 8o0EkD.6Z1tI2.igRLYKHgjEBAFxv8jAkAvpZlIwLbspjHnUUExOZ4HzhdmLuImOr8C_bXhXZHyN
 Sou3TLURbE0xJOY629fmMzpzo3LibiHph4nN5lngWlXE7huE0kaLFuTkAEbdfdHy4i43mQhvW5HY
 wjvRWb8bZCZ2Ar2il5trHEEORH.2qTLgmIYwQXibr69BbzLyVfELyjy7tuQqYWPVm7i1sUdTcreW
 NfyxvJ0yylwDRQWZQj.PvXZIX0S3lCmAf8eu11l0OpkoNlPCeuzjUMBFdZ.OzDc7hEuLp9oA26cB
 ZAwZ5kN7onGX1TOyonSZJCf0ACL1bDbi54MMoBjICs09lRvvjaTHL3QbyvaTHqAyYTFSP6p920cM
 dlCSdHhPERrLWUKOXC2sY.KT9UkoBu85mo.uCgP1tALEfRn37j9MkbB9uv_hLdnDk7JtEpWooNue
 o4YOBjbK5wdG11RUxwuzmRo60V._tqdKj1jMPunyPTrcJzLqIaoGnPR9YopbCQUjVIu.4cJKu8F9
 q_zO4O8qBm98GBdr0GPTIRLwpgUPLC1Yl_LBrfwwd9fDxY4XMYfm4PgoyR2LZHLOF9wiObFelR1I
 csidfailCFFswHaupLjsLRHD3qenRW7OGEsnoGoxTQ73WJoYRDMSVT0fu3t2d0YO4dYqE0h3jjeA
 nJNu.9YKJgiEPvfaJ0uJjRn5ImTeaH.1ln8.N0npT07Bm0xpJdgIrIkwi8xOIGqw.Tf41ElMO0gk
 nrEfUcU2hX3jQCA.DaylH5NpWF9OUo9gdJ5NCZJHklVcd.vCZ1E89NMfNUncIfTyiQj9a9qvJJDs
 qF4p.9.jcSvx7PEcdl8sUVlG1QyMqwIbxoy57ZJ7.VCFJrpDbkjUXr6.ZrFyL96NZTOQZTdFi.b7
 EUBQsoRnn_ps08AAHgBlzEmsD3DfaQOB2sqU_VIUfLVJ.rqP.v8nMChdgmtQ1HWyd
X-Sonic-MF: <d.piecha@ymail.com>
X-Sonic-ID: 54d1463b-1d8c-43d7-befc-3c2ef5a899dd
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ir2.yahoo.com with HTTP; Tue, 6 Oct 2026 11:40:08 +0000
Date: Tue, 6 Oct 2026 11:19:25 +0000 (UTC)
From: Dennis Piecha <d.piecha@ymail.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>, 
	"patchwork-bot+netdevbpf@kernel.org" <patchwork-bot+netdevbpf@kernel.org>
Cc: "andrew@lunn.ch" <andrew@lunn.ch>, 
	"nic_swsd@realtek.com" <nic_swsd@realtek.com>, 
	"hkallweit1@gmail.com" <hkallweit1@gmail.com>, 
	"davem@davemloft.net" <davem@davemloft.net>, 
	"edumazet@kernel.org" <edumazet@kernel.org>, 
	"kuba@kernel.org" <kuba@kernel.org>, 
	"pabeni@redhat.com" <pabeni@redhat.com>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>, 
	"kernel@pengutronix.de" <kernel@pengutronix.de>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Message-ID: <503211732.1051249.1791285565321@mail.yahoo.com>
In-Reply-To: <179081461327.2189941.5041238879527277665.git-patchwork-notify@kernel.org>
References: <20260925071040.2137178-1-o.rempel@pengutronix.de> <179081461327.2189941.5041238879527277665.git-patchwork-notify@kernel.org>
Subject: Re: [PATCH net v1 1/1] r8169: disable EEE on RTL8168h/8111h
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.26668 YMailNovation

Hi Oleksij,

I tested this on the affected machine with a Home Assistant OS test
build that includes the patch (kernel 6.18.54-haos).

Hardware: Intel NUC11ATKPE, RTL8168h/8111h (XID 541), FRITZ!Box 6690
as link partner, no VLANs.

With the patch the NIC reports EEE as not supported and the RX stall
is gone: more than 4 hours without a single drop, everything on
defaults, no workaround. Before, on 6.18.52 without the patch, it
stalled every 7-20 minutes.

Since 6.18.y stable is affected (that's where the PHY EEE fix was
backported), it would be great to see this there too.

Tested-by: Dennis Piecha <d.piecha@ymail.com>

Thanks for the fix!
Dennis






Am Donnerstag, 1. Oktober 2026 um 02:30:16 MESZ hat <patchwork-bot+netdevbpf@kernel.org> Folgendes geschrieben: 





Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 25 Sep 2026 09:10:40 +0200 you wrote:
> Force EEE off on the RTL8168h/8111h (RTL_GIGA_MAC_VER_46) at PHY connect
> with phy_disable_eee().
> 
> Commit 202fef9bbbf5 ("net: phy: realtek: fix EEE advertisement write on
> the internal PHY MMD path") made EEE actually advertise on the generic
> Realtek PHY; the write had been a no-op before. On the RTL8168h that
> un-masks a latent defect: once EEE negotiates, RX silently stalls after
> ~7-20 minutes. The carrier stays up, no counter or dmesg moves, and only
> "ip link set down/up" recovers it; disabling EEE keeps the link stable.
> 
> [...]

Here is the summary with links:
- [net,v1,1/1] r8169: disable EEE on RTL8168h/8111h
https://git.kernel.org/netdev/net/c/3cdeaef1754a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


