Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=66.163.189.146
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793983397;
	b=NedZjp3mrTJsMZio6EtWFmBMJViTikVML0Qo7vQ+mMD8UxDo1OFGxwFnoL6hblC1XErW
	 8MRvL8wq3AfxRbQQLIPNvTIQlYNFSfmr45yueGTqpyJxxl0A1A6YU3CD7eQCKRCsJGxV9
	 /x1/IZO1OZHe1/V8qDB+HMBWRsQCA1XCMgtBhglB4PXMRqBhHldKOIi7hLxxhlznhGPUa
	 cYrww9kTK+7AIofRDQOutggKpZrJmJWvYzPWC/WGG7WYLVRSB1ltFt3EiZgVmszxy/KsB
	 SWrTJX77pJ415du5AKppYyTJZoTHdUeQfn1Q0a6QncuWGz3bZVEgOBohbugRX5tfrsA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793983397;
	h=DMARC-Filter:DKIM-Signature:X-SONIC-DKIM-SIGN:X-YMail-OSG:X-Sonic-MF:
	 X-Sonic-ID:Received:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Mailer;
	bh=lHtWxeOu+Vjsidq/9GE7H1E4u5AgSxusjUPdoEWHkm4=;
	b=tTYevPZsXK9a94SqOu5CMn3ZLQcmU4G1JFOvH+pVWcZE17QigUo+W1GUdkAsOOJr2XgR
	 hPHyLtIvPyhVFOv9B8dbc21KY+DXc+ghdrakRc70RMzZvh4ya5LCm1e1LCcnTMLtAnXj2
	 KvW2d+aONqCvoCW2syaJm/28bPegt4yVekxGVs2JQdbUfEAdabvIJrBdnz2RsPJKjofUq
	 pqR6UR2h0VAIwe3E8jU3+dWh9a64Pa2Te0TVNqooOOujHhk3rI17KCEE8ypM36Fk1bNyz
	 lhCDGrbdPXmek9h2mO8j/BuO5zwtqMdBft2aNMTlznZpU4a0QgyS3b2dA0pO7KJVEwg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=yahoo.com;
	spf=pass smtp.mailfrom=yahoo.com;
	dkim=pass header.d=yahoo.com header.i=@yahoo.com header.a=rsa-sha256 header.s=s2048 header.b="k4eXN/Uo";
	arc=none smtp.remote-ip=66.163.189.146
Received: from sonic314-20.consmr.mail.ne1.yahoo.com (sonic314-20.consmr.mail.ne1.yahoo.com [66.163.189.146])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C14606A329
	for <netdev@vger.kernel.org>; Fri,  6 Nov 2026 16:43:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 59C14606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=yahoo.com header.i=@yahoo.com header.a=rsa-sha256 header.s=s2048 header.b=k4eXN/Uo
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1793983395; bh=lHtWxeOu+Vjsidq/9GE7H1E4u5AgSxusjUPdoEWHkm4=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=k4eXN/UoC+3L1x6z0LGjcncS91d+I0jc8r6sBacjlb7hKXyS3ubpIKk961953+qqLIqdL63lzNoAIrGtIHUfZ8WyjJGUamW3IXCOy0DyjEDykFEADZ5dYIoXE7KKPiIj1Vva3FuIjj7kRFTFRcDdBS+FTAx4YKcEeJ8AaFAzccwO/mh+kGatMA5VRxhpoF0etJ0VycIRgllOLIWb6Xg7D6PQ6HdHDqbonXukLSY8CdgsKVAbvuk/nlRUOg/qXXr28fvlxPTxrL/dUhsrix+W+qXNM4pjKgDI3Bf5WYQO+c8y1Kg92Ir7jZO5wImspf64j7LyKB7UjOe0P281cM2eFQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1793983395; bh=xeGXEN7xVuIfZ+ZQdgxXxQeg3Nn1ehlJr7QQJbMrz50=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=gaUFAvAlsYIpP0fvEZxuY+/sWCny307gGq55Ez/xdbob/Ykzg22qlPZ1kd/owK74tN5ko0kfIWAW2OxMaCofq0pb8iDUX7Zqn8BhojMAaYY9BDx5ixWzawJRMeGG8r52jab/wlLMNGX+IutAzq5if1zghI+NAnrfXFlbtofjiYjiCvjsugWchKvyaJA/3PGA8EGLcFdJurpcurWslKG72kiLT8geaPzgf0eXjlffcDOGXRk0dKpMFH2TjpfOw4IJ0F4N+tMg7spt1wwHRSV3NqocFZnmvRwI0KTOiB844Ax2SsswaQt4oT7+vgzcyJdRP5Yx+Y7lRjKvhWen/dh2AQ==
X-YMail-OSG: OIdV4lwVM1lPmZAovyYZP5BgZ8acuGF1ApxlFCYkwNXE2BMQd85mdoHC9KwKreH
 WuCdBA_4i2NPC1nAeW84lkg5t1Ibn7tlSEYn_dommb8N0OqBHfguNVgPT7QdmoJkq.RmbnlSkr_I
 X.bFTHpqlN6PXjCCqiOLBV5DiauNdXmTmwdZHzdrlnG2Dm8PaI9x2Afauy6gKuGNSkInsWdCL_To
 nL5pQNn8op2NHLswzYR8RQhdTJ0bPMhXBbMBovUHlfMj.y.ztfsqggYpfP5u4hva5jqveMPfRTWZ
 NcP5yDgLOnz4Ay5uRPcB2Ye3dXjGcq3W1TAye4CsnHa9Xrck2RXCXgCc6_n_O6FvUEWk.zN.Hicc
 a3A9qbnpcdz4br18N6V9MSsNIECWcbcsbrkgk4CJHbT0yIepqG7TN_Vw8fMfaUoY9uJ7qOgsTYE2
 WFvNtg.Sdho9ez57ybQP2qtGVXQR3ZSswsAWzyL.VZdMCCCvSgCfsqgvxTLw_Duzp_y8HB0JxyZ3
 yZaoZgf.IEfXKE0xXa3ewA.I3LZLRIAw9Gxgn8S2XwDqCrQzzzw_PRpw0wylPjQUCd5zGy0t16tI
 5Y8gEmOENMK3XwvUDJF8YKIilLlD.GHV.NUl80ENQITlEA155ZGmjuV11.LcEaeFt6oRTkEbnErC
 1sDM1rUZqPhO5JEFIn4INzr0DpSukFkdrDVs6ZkDHEQpMihOLBUFOcYKU3hnfPDiKVzO_eIWX8yi
 QCJVeHtKMyJS2w8wAzatAe5h_zoKnegkJjj9nf63DQntlVKFeJYSY.YHv5Hibg5rIzfCSNa0pzm.
 QYuj.svWqNmbfSUXIsn6Plp4ACe1e5.5i9wF7ZZAiCCjMuw2pTOBKFB7NaYXWNWApY_Va5S2LpKT
 SoHFLM4B5eJlhxZE0SgndQw1hlAzOVFxh1jAgC3y61GmySzrOnta9O2rNZNI0qZW5gaSBSrq7u4N
 SRKpe5dBqFnd4jy5ow3K2qINws_aEUJuatLp_yQK51.wSMi5aE4ueFHwMLrNBFLH1cXAqiuH.P2R
 h8LBvJAxrwSvt6eqbnc01TvAmhj9iEfUZsLyZ1JG8OM2FyL.DEYXORf8obNR1klxDsTc4poLvBy7
 j8UbyjNIJ_ImTdOFHniQsKyufwibh2lekKyaiMfbEnfis6W96RI0GGDbzq01OcnVl59Wp9__D0xx
 kXbstQi9e6q90l3n9N_QdAneqbgW83w0jyeRpUeBueVo7UJO78jGBPrTZ.iBnq6ykAPFRrc632Eq
 GsF8ywISpQKFUUAx3P5xgWogJM5gA4BLexuYb_Aq6ggdSHpzQ.gtz0QTNn9B6sQsJGUmcQUDzNpB
 OWcH.D8I7MjUZTU6bnekSYonIn9YqSK7bun1wHQbi3lmbAJVsyOVnQ52tJQdWm_ewWqf9M8IGStt
 peoUD5P2DX0VAVr8rMezeji8PzlywaiCjgVZUDtX.QfuqXU0jTSaqhJoSDPtwLZBLsd7Apvu5mM_
 gnbPODsl3sP5_9uDt3UtdIT1zE3RGf0jdj1azU5QyCyuiZ6llyQ_YOj9LQ.fsep5lzHevSr.xlx5
 2UJE2penUPvka0heqdBR7leVfAFk.OcU7Tkn9o3TxNhFBlPaY1L4ojEmfMa.JaHJMd8bX9XOWWzB
 Bcf1hO_uYepwSy.JSLfDA9jSYjzfIPf4YNXKYHPbOnxNXIxe8_AI5f28170p5MWOoRfjM1te6HWP
 R4FvwPUNaIRsTaN7YqVg0PhoO3XZR78UPQdb1no6VTrmAOS5.FRpyXdVwZyW6vSSo9bdT5vzI1Vg
 B0neQ_oSA3UoP3ODNvAFJR_HCzaP.8cspcpHzjo5h1Zoac86N9pf_ajv8fFGjhLzmvONMRWir7Pl
 I1V0_WcBSjw7KFH1l4WizDGAxPX0O3dco.yeqfL7DIhqRE7kSwL1wZzEYUCQznkkI5F5Xl_9rxYl
 n2BEnYJ.BM1onjH6n_ijRyPgcF38h48cwSfPkqsT57MZLYfycXkSuP6q4tR85Gx00.8sscXNV58E
 DFqMu_cJQHlYI4SwCS9PN0ztetrY2_NlUShDfuC5KbF0.Hg_6_iBO.Av2U9G7zFtBq3YXLcULuIr
 DxEU14.0qC2DBCIPJ6R8a_ZOkCUqOLXYSL2jMVYg8VvLme0HL.j6JP7TyAkvtOUiEkz3YdnXSrRu
 DLZlvtU72SWxqAcjdAZqNS9fKTDMRI6lz7a6Htg7DWWjO7ff6rrvpSzE1Fpn38UCK6GF1cAr31Po
 IyU3ibCiGU359fEjTjs_Hfv8Qlv.5Y0MOuWeTdP0FR28SaTzTD3vBPX.zhAq7ZEFi58F3b0Q.5RF
 CCx2ciawjDSeiHy2Pt8xpOcZSNnQ_a4E4D.b4Iko-
X-Sonic-MF: <namiltd@yahoo.com>
X-Sonic-ID: c1d3fb05-0050-4afb-8b7c-fa4c4a0a3348
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.ne1.yahoo.com with HTTP; Fri, 6 Nov 2026 16:43:15 +0000
Received: by hermes--production-bf1-6d6877594b-clgz5 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 8dc6823223f8f1de6ed049ff776f8c37;
          Fri, 06 Nov 2026 16:43:11 +0000 (UTC)
Message-ID: <29bfb266-8bd4-4c59-868a-cc27259c1f16@yahoo.com>
Date: Fri, 6 Nov 2026 17:43:06 +0100
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 04/10] net: dsa: realtek: rtl8365mb: set RGMII
 mode for family D
To: =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alvin.sipraga@analog.com>
Cc: linusw@kernel.org, andrew@lunn.ch, olteanv@gmail.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 linux@armlinux.org.uk, luizluca@gmail.com, maxime.chevallier@bootlin.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <3bf4dd70-9771-497b-8c27-e925e0ef81eb@yahoo.com>
 <2befac48-25eb-4c1b-9632-2f3237d68a3d@yahoo.com>
 <auskP2mSY4sCRa6x@analog.com>
 <82c96971-be5b-4c11-b20f-c4b074181515@yahoo.com>
 <aux1v3R-efbWF2GD@analog.com>
 <e66204e5-ac33-4a35-8d36-6f37372da97f@yahoo.com>
 <au3WTtBo3qk4nQvf@analog.com>
 <014d5582-8ce2-46dc-911b-397862492421@yahoo.com>
 <au3t3XC2b0ZGLN4A@analog.com>
Content-Language: pl
From: Mieczyslaw Nalewaj <namiltd@yahoo.com>
In-Reply-To: <au3t3XC2b0ZGLN4A@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.26943 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On <DATA>, Alvin Šipraga wrote:
> On Fri, Nov 06, 2026 at 03:56:18PM +0100, Mieczyslaw Nalewaj wrote:
> > I do not have the hardware, so I cannot read the reset default of
> > MAC4_SEL_EXT1 myself. [...]
>
> If you don't have the HW, how are you testing these patches...?

The code was tested by users of RTL8367S-VB devices from the OpenWrt
GitHub and the OpenWrt forum, who built it and reported back to me.
These were basic functionality tests only. I do not test it myself, and
I should have said so in the cover letter.

> I think we will need a Tested-by: tag from someone(s) with both a family
> C and D to get this series in, if you are unable to test things
> yourself.

Understood. I have already asked those users to respond on this mailing
list and give their Tested-by tags, 

> Please also do not submit anything if it has not been tested. Maybe it
> was, but then please get that person's Tested-by and put them on
> CC. Otherwise maintainers might merge this assuming it was tested, if
> you got the reviews... It is a basic assumption that non-RFC stuff has
> been tested when posted to the list.

Noted, and sorry for the confusion.

Kind regards,
Mieczyslaw
