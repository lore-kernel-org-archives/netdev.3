Received: from sonic301-31.consmr.mail.ne1.yahoo.com (sonic301-31.consmr.mail.ne1.yahoo.com [66.163.184.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78AC126CE2C
	for <netdev@vger.kernel.org>; Sat, 16 May 2026 15:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.184.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778945606; cv=none; b=sAl5Ph/PtRs9hgLoBgQ030V8F9POQoeZ2hwgVQrm71A7LNsDapUHiZ6XwBcg6R44l95H4hjCOEkx5mO1akm5xjbrEmMbQFI8w07UhcRwrwXQcniUUlt4xVQI1bT/t5CinjjTNX0Yc/72HON4JwT9739YzQ3ZtuyXUJPPxe+Eyp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778945606; c=relaxed/simple;
	bh=/TEtL4jjk7IQvbzA/IpH+p4v9g2/HAsRX3QLbXt2yBM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HC89r0ZcTFNf7d30D+ydXjnYUIcvr/nvqhK6w+tz8tuQS6cS2M5AQzylYTBrlhLdZdqFzxqwPru6oSYVXqyzVEe7slpxaar3288NvPnlC0zDrVY5ORno4LOiNt3LitqEkSt14NIfjv4xnDPPsaXRFQqmxcOrQHUAFuMpCbZYlQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=tz4SqZu3; arc=none smtp.client-ip=66.163.184.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="tz4SqZu3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1778945599; bh=/Pc5+0s0DBcaI4JMa96lwkdnTTUOg82EEYx1X9ARoDg=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=tz4SqZu3yP3esMLsTzuDAVEAb8eWvwoQQOYXW4fFN0UCAgpIxbuwexseTvSNX7KETyeczzLwao8sFwiWW+6yFj65jnRU4SgpSUDpgU9ZNyq725oZ7YtWqOT1QYiK6Ndy2XXfvNPe5GtZUuFWFV4qAkVwzMcaBgO3ThUi/Eg75pYec4O9DxN+FVyxFIdLVTjC69UasGDDcosbAE+3VU6oCEtMmKGoEOnLvN5AEZiDRqcMJ82znbju09QcFUCj7p/27LSmxor8RegY0NribN47HuxMfmHjME+mIdHySa6HSy4lM/iPLzJRpXZByyC5aS8IVMqKWUEnJi95FbwJYtv7Ow==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1778945599; bh=G2ERtnW7cn0WWedpOFE736ijKdPK//I57uSvU9ywhsw=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=LYN12ClQa/O3s/6c6UIk4YbpnmLLOXG1ez1fW+ZWdh9dUPHHyLVKmifiH1Olwk8+mm/wJc8mAUMgFIR/L/tIvofkYLBorjyusgDEdfV7tMaYST/lVR/8COktvAjpN4q4cpEdlyFU0x/pqNSBfAd68/J4GzVNK4Ti6rSpK9j/M2wnlb6nGYreXhd8EbYsK6eIMbmkWgonFcn4KqjGx37NxWYqvtBRaw+Zwlyj2bJ1ZLBxkRPar6ovBbuHWE/0YdluWEsltjMFsPqVMUEu7HQIb6iAijpmZb5gYvj96pmw9f5ImdPT6I050oddsVrZHO/LO7+Ra0EEeHwd3khFgdIBUQ==
X-YMail-OSG: LAn69mMVM1k7LjpZ1Q8xY5_f4ovN7Q0C9EjFEPcENrVJH_s1Q4H0JNbMKJUdjPy
 q71OVTYNRNfmTFzQ2miGb5eF6PUvnGVBRmaTDL4GbjCZuMFU5ZqD1o2U_6gBoa3COGi5HGftkbFg
 5XhFJmMCm88pXHBrFTCeu5go0JBcZiuYI3AJlal0Jdm55VYpOS4h2ZI1GUSHPJx5NiWyU2o731ws
 Zyg9UAo.R0KQzo9bzKjHcYQhrWWKmWbi6FWzvK23Yod1Z0b4fiJkDD.frk6scuxderdydw1.fK2e
 sIwf3HtfeoxowBB_Yn0hRZMMrmOwYToQ5lS0eQj8RzaBFS9x2yEXdSE3izFNiqE6eBvLcCO10GRj
 vAnMgEl7pIQcACbdL7qArMA555GUX97t8D9.crzIzTT5472qDu.xDqkM0rnMZoCqyGMWVZeEZqxu
 cGznU23Hn4vna2eebzxDrkGBQ19OVGEvyLu5AgEawWAUl0UQEw5JABDziBJILKIKbro7vCMl20nW
 fO0uTzaUkfmTnLkdgXUMTewqGln_mTKNEG8KdH2CUMLx9u4amED9VlEp4eixUi6mV.wCk6Y5WVfT
 QdzTr.r3cZC5_0HAtngpyIWj6V61mQQ2RAv1i26Ka8ZgZVo.QGZRkePcj9jwQzjNg6imCh2GQh44
 xGjYozDEZA59mxKZFNkUnCD2qkukL_DWpAFX32UsUv21Id4ET.PahRyke6SAHYyZseEo.etLpXEM
 H9WzE_GmKZB5awqB805iTQwuj_Rlz04DYImMlN4LbG8xHcvxQVsQVCKRupUgPfz_i_aXq5I5ATYH
 yUI9MA6dPnv97MOKy2Kk.kKDuTZTteCc4aOzpeH_YcYLDtAQekRVFNG3L1W7ob1lsyv8ef1F2ahi
 NAn3ftdgEWqMQIgcDaUpNdXbesjKYyfJid6O1Mx81AhTZ8XaL9i32OjAM8RpokCO2mreAPRCB7A5
 xVtwZqgN8TyCLTFOv9Qrvjt_2YX8BulyqvtkMl4mRb5eXiVLiS.HRFnKp5LOdh3qRDBXumx9sgCk
 gQ8AWfBHmDkFbxwbuGSCKw2nfvahuLDOZIqyoXsW2rvroJ46kTOiEVVrIKVVReaXTdXfZvpC7HKO
 .DPIHFW6lezFODb8H4LnIGKpMf4aENlkeGKOlnrhFKVN_edzbcWlbgd2VNHAH9wn0FF930s.loxH
 12sUMaGFXQ.HsT3aIhix0p27Ffr7OKOvokUBwbyOkhD5T8zbRZnGULE73ms0CxLzJmFpHOpZXgnR
 k4jO6v7ZrZabCGi5m6ete50cMEZxMKfCYSC1CMs5uNhBgfFQwC0WOITK2G_AjOkGn36rVUAMjy73
 P75OpGivCRHkOdKGgQaVVjUP_U4IaXvQp.hrZJRje.s8f2CvyqWD9G94VqE81we.BT6mKDz3PB0v
 DURyVHFGWgamwUmbMxpfp50iy1Xc3IIL8_UnP54A8YcgUTmcD9.fuGWgWHIJyECQWnZwntg1fB94
 ntlKrg48tfhUaK42RAfxHZu7ugvt3f2VFJ2ANmTJ6_5FI8l6FBo8zU3qIngBVI_9npZKPV25Vhtw
 ZMp6UZnIY6gaECo0ZusqKe25_cmoY6JEnlED1qDoWXawksg.6QJFn6_L0t5uQewMHZM4yNkeNl53
 Q1FThMGlueKq2k0Y_uepwYANlVbLeyhWwZT1jZBs8BCHV3rdR9RABkU6Con_WFJvnSjsIQ.o2ED8
 W.HkA9xhiaqrx_IfDo6Dgl1AweVkFpANYmhLBJEPyBTgybTdDhbxgixcFkur146msMnk3Tz8qSNP
 a0WOcMqYPGfw4LMAv2xSdCcTifC14NcsbTpOSPFAxaamW2woH62l7EHyW4EoT.8133ePk8NVmBje
 gWrVckLu9dAQd.yj3gwVMzAOJ.aqXIwYm_TQ0GuxBTU9EIzG30JyRQy.o55xybhLWa6pwg.pUnfz
 jUts6ySndSbhRuAzOiYT0f6S8vmaAYGbD84fxt5K8KCDqMNqxYD7q2K3kseAlEHl1Q7l5XPnFrBb
 UTltLNFCZriJkpCrhGKCjujobGLBCQObEK.eyw5H1S_IBcLSmHwTvvXj3ypTzUIXeqZm8G6_lhwP
 ilUsgOs4Xdw5kRysD0kWsf1exc46dZvrj525q5FtSwb0VMJnyb7ROYE77yOFJMWWH40O5mITZA90
 bGs7eMSD1rg7j55.IaaFn4buHE2XkbpzKxvQ8m4MtwPUAWs9.TFbqFfI4g3VtbLbwiNcMEYHOuI6
 tRTW8FGVkPNmpS0.tRVjoOyOCnKq6QFRarVIBuO1FyA1h33H6K9zTaFj7d0gs2wLyH2op9UVOuMW
 QR_XXpp6yi3bCrwAwb.Xr3VFWR_LjjXGI_Z7EbMaE2NML
X-Sonic-MF: <namiltd@yahoo.com>
X-Sonic-ID: 581d1536-8c00-4941-8dad-b4f8c8614f00
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.ne1.yahoo.com with HTTP; Sat, 16 May 2026 15:33:19 +0000
Received: by hermes--production-ir2-89844b765-vmp7w (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 4f12658f57655b845c202743679c6226;
          Sat, 16 May 2026 15:33:16 +0000 (UTC)
Message-ID: <2d82b222-7017-40d9-b66d-0d57434b92c2@yahoo.com>
Date: Sat, 16 May 2026 17:33:12 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next PATCH v4 1/8] net: dsa: realtek: rtl8365mb: use ERR_PTR
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>,
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Linus Walleij <linusw@kernel.org>,
 =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
 Yury Norov <yury.norov@gmail.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260516-realtek_forward-v4-0-8b6d6a1eefdc@gmail.com>
 <20260516-realtek_forward-v4-1-8b6d6a1eefdc@gmail.com>
Content-Language: pl
From: Mieczyslaw Nalewaj <namiltd@yahoo.com>
In-Reply-To: <20260516-realtek_forward-v4-1-8b6d6a1eefdc@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.25725 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 5/16/2026 5:46 AM, Luiz Angelo Daros de Luca wrote:
> Convert numeric error codes into human-readable strings by
> using %pe together with ERR_PTR() in dev_err() messages.
> 
> Reviewed-by: Linus Walleij <linusw@kernel.org>
> Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>

Reviewed-by: Mieczyslaw Nalewaj <namiltd@yahoo.com>
