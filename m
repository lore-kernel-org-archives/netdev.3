Received: from sonic309-20.consmr.mail.ne1.yahoo.com (sonic309-20.consmr.mail.ne1.yahoo.com [66.163.184.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD83A48EC96
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 14:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.184.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791815148; cv=none; b=huK6rk1AFg8GE5VoehFu6e1h52Xyc/nsDiQBO7s0aGwK25WyBnSn/Ll4dhd4QMr2eQqArb8y2cYHcUqYijzb3yKb0R/BSPCP486kajrGDbP+zL63YxMWEK6f4PnjvhU6C2ujPuNx9qFguJuWKv/IWJi6KPN+dqBMdrTeC851S9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791815148; c=relaxed/simple;
	bh=gqeA3YGrzYhrDVDyUZzUyv97cEqLCeLmz633sVfH6MI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=O90fLI72fEHPKz1S50yfw+DKPfbCp0qPMGjqfWgC7z+sDAFQ9iiL4FGPN2A8/SrY3pez4KrS3+884eCf56wLZrko612fDG5MnOZUTt61Oyv4HSzyP8HaEJJ9uNlVmv94n1s416dW1oU1d1lmfJYTsCozpZPCS+8QOQUN0Yoe/AQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=Mo0AAn95; arc=none smtp.client-ip=66.163.184.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Mo0AAn95"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1791815139; bh=F5gNCyG2q0mjkOp6cibi0HD2gZBiEPKlLCXkZDkPLBA=; h=Date:Subject:From:To:References:In-Reply-To:From:Subject:Reply-To; b=Mo0AAn95sGWv+js0saK4o/jTyNwTM8WJgC4KIJ2Beyyfrbc/9/jn1hZjJyUJxzkNKsGpDmU0QqjdCiOaefavWaqkIK0nTpnghFGZ3OemBOa451wDvhkgLOlBytvUzrov0B0UA0a/xKXtniS8F0j1SYmPA8kv7dO+aiUDpgIKuV1E6A0FXB8QPXAZZyJVUhsfSBj8ek+PGsMwXbPkvwjYeyykRMCIIgWoOf0pzGchBMv/jrfFmW7xqJJ/2xCcGakMBb46d59W5kdkV3mv754tNagXIQHydnrYy2CJpqVIv3LEvj29fzeILIY14Bx1cxKG+92J9TlikkmxHVnITVMcOg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1791815139; bh=Ii1yW70ZZHC0p+/B0cHJ8xzFDW9uxqMIS/sipiuXfaT=; h=X-Sonic-MF:Date:Subject:From:To:From:Subject; b=disVcuUyyyCcqdpXDuTd8Vl3TZiUa5lpRVr6Th24IFXONJ0KbMM2XtCtfpRbGfMkJZ5ZdTDc9a6SbO7zZuHpyFKV3wMxcpmXKhApAdQv2PRCMnKg5sx/MxYP0mCFNeCurFGF2q1DXhKcdn3BUpCSMAV2sjAiau/DCs8/VcnTwhJpRZH53RF+5eIex38mv11xXG0Fu7mFvpgIlL9pEnGgYUmkDlfLJZ0DXGE9Yq6zzO6skLZaiKqtE2V93usD7lLjmF7uXoxerSys7dcux0SGKS17zGWtq0YbrQ+uvn70F6Yu1ZvQMZOgJtEsO7JjJ+P8f8e6zFS/qEW3uhSTDbhzWQ==
X-YMail-OSG: csD59ZsVM1lydLlEYKzVS_pjoNEbjDU0EDP6V.p069Bi4LCnnn7I4M0bjLERNKl
 oX5m0DDlhnHPTQ1A6jqnWIVFKcvCzOOBXkScxFA1v84hq_GM9BKdyIXuOMEGhsK6w4RDT_AsvmIT
 Wv.nnRVLdWXtVtXBJmq2c9Ojzd3P3pmhFdESDnDUPLBLFkvJ_bc7vZkjgYybR9vBd33SffMEVgwQ
 j6fQltXrXkyTc7WgaLIdd4LDPD_OHX_p9rUIMZ2FcN0NRyOlKFzsPV4nLu.zKt6uD_NYHpV86D25
 G9ZIoIj4wxDRMhxGl7qkEBUXqO3dPHKN77NO7uSOU5cyjH0mP1HN9sQFvPwn7F3dZ2VvfG7VjEXb
 ZFabTKL8wLH_sIvWWP.ZEqpyvYdoY0FNL0JWYrcbqg.TMUODtqabtm5sA6C.5Ny3CYwq.RpbiJK3
 jKm4GKRGLFbhKagzc2XGCHaqFokdRWaq7KLlIv29D51tnA3AldLfSRYT2CsKtA00C5yzz2h.Q3bX
 thI5iOa8PqYFq2VFCrpG6n2clAb3PoQ4TajotBAZqOYxBdCEFm49iil5alode_JunrtZva6GU7j4
 OJ9xNj5C8baB2Npj_5B0XXVjWjs78fd_WwNBDMEBa6n983r4F.qocx2rgHaCasPYhRyFAPZxd4eu
 YoJcECgChuSDnAsQ1FFKXcXQN8Hkd_htP2IpulwF3YkVzriw1OLZ8fPT7q8x_CKMOf6yZzcETNzQ
 p3VkAtCg57_XoOChU6o2.MuMlAfMFd.ehQuXxcx89cFuYX_l01DEcCN2Kydy5mavPTz676DESY7F
 7aTigtryft2Svigc2tPdIF0SDjXv.NgdqnV5jBDR47nak9yPyaHZ9De4PbQ9XoHb4ezoG8MM5gxm
 ydzHl4ga8DKM6o2RUSAkKqVByvIV38zKfm_D13wfSfCZQHhJGOJ8V8nnpiU10mBIOkysyh2zzZf0
 DyHDEtVj4a0t7Jg4uRV3hhEmihittzZKgBH5F_fvpYrimc0Gtuz7MZCBYNID4FhAxa7D6JWmkA1e
 TgaXUydayX0Hqn3eFJxpyA9hG1ipmpB_vs0jFkeLuIms5B4eUWgNbcs_A9pLR2HgDw5LL0DTQsO1
 89.jKn5HXiNFVUSNXbkqiOZ5ekxqVQ_xsLJgpsOUwPhy_tZvVk3G5MVcIONr1phuZDWzxx0dvMFP
 RDgt33P.sP1_Lkq9RbLjsKngpKRTx2JO7AXwd9VQn_El_WR0dsUjOdE0wTnSzHc8QzkEqkox_iGN
 B.epJIzXMmF7CpBIoZlSidanDfNfJCArpdeW0PjGc3N3IfEbMLK85XDgeOFODzaXxDXp_XxKrR33
 Tx.lnwD72ETV51r_e5GLndzIszVpSKVt.5w5FBRKCbd65kp_x.5T63VcJAs5EIvvVermJcYF7cNw
 yJGLPqL.Yc920ZEYd37nbZtYTyfg.qAGBCJhlNfKrRizY6ygjW0QwhEcqLBpwesebRSIHagYiZUa
 pgWCssksHXB0Z5Q6C4GP_K_BSfL3TlFsMS.G0SJZ4o15nCXxe1grgLim7QerwNV7aBmjFntTKSqo
 Qj6MhlbLQ_LcmWtVBydP5Wrkd.O0cBKkWGtznE7geb5a9TOwN9WcdMxWqMddsc6YRnQ7tIKlRZFg
 WHzc4xdKmDb_.awplupw8K6jEvh7YjYRWqVyZiATdenTnyIF_oST6XYryaMhe2seoZSWJETKHpkZ
 dirbSyyEgNlNU4vQIx2O.4SlK3tDfG0xob0YdlTFCo0_sb9Lo5y0VWS9di1LoHLRLQi0FVrlLfDD
 BLa_QQkpgXlG2anlSoCfUEARbmC1sYM9bCXEVC7gkqI0LSjU6Lu9cxMSnRwiL7FZPr4LCQZuZO0z
 oLxmqwUWvGgyHoKawSivQUIYA_D1bqG.y12IyfwVu_HOD6f_0eXjSikbmzS.i1ijEMpmEYaMS.ud
 sQbAe7ijjlZAT5IkiL.U1EIBts_GvnIjSve2LsimsIDVljgNort3NzMUB39qY1nXC8vC7eubsUNG
 mKIOsdbqm0jLbHimQ_g.VVWNPApshAFKc8Oq.5.wW6LBUYq_ff.eT9xWj.f72w20YrOLq3haYfn5
 UQJsyuzlQ6PsK1GvRIzF1EOAIJeDZUMRBxK_jPDtAv_XI2Qr3gPMW8iw7uuo7siByTLyVxjtqI2E
 5Uy4rINUnmG3Z0B0AA4kB9PD6cW_HO71V0xprtxgYgdDgBzJQYbxWcIBYTKguG5wvy5Nff61ltvw
 C0mh_TeHVk9Kdjziw.5xEnMwr3epvlCdnfLziZtyxZgGKEuLYm07vTur3tlrVScgKDfk5AWaz0l0
 C_l.SCOa741LSsCJjUyYf4NbjF2mQcJrDeT.JZPfvtJwc3zkyrCk-
X-Sonic-MF: <namiltd@yahoo.com>
X-Sonic-ID: 5f644e29-6e1b-43b8-b297-afd9f063bd2e
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.ne1.yahoo.com with HTTP; Mon, 12 Oct 2026 14:25:39 +0000
Received: by hermes--production-bf1-6d6877594b-qr7mx (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 736e5eb114076bbced4dad4c53ac869e;
          Mon, 12 Oct 2026 14:15:21 +0000 (UTC)
Message-ID: <5adc200f-27a8-4520-a7dd-bd8a3fa14db5@yahoo.com>
Date: Mon, 12 Oct 2026 16:15:17 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 1/9] dt-bindings: net: dsa: realtek: add
 RTL8367S-V
From: Mieczyslaw Nalewaj <namiltd@yahoo.com>
To: linusw@kernel.org, andrew@lunn.ch, olteanv@gmail.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 linux@armlinux.org.uk, luizluca@gmail.com, maxime.chevallier@bootlin.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <38872e6f-1264-4a93-9f81-8212173e909d@yahoo.com>
 <5dbd1b29-72d0-454d-83e1-19f7232a0ee0@yahoo.com>
Content-Language: pl
In-Reply-To: <5dbd1b29-72d0-454d-83e1-19f7232a0ee0@yahoo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.26668 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 10/12/2026 2:09 AM, Mieczyslaw Nalewaj wrote:
> The RTL8367S-VB (chip ID 0x6642) is supported by the rtl8365mb driver
> with the changes that follow in this series. It is identified by its
> chip ID register, so it does not need a compatible string of its own.
> List it under realtek,rtl8365mb.
> 
> Signed-off-by: Mieczyslaw Nalewaj <namiltd@yahoo.com>
Sorry, the product name in the subject line was cut off by mistake. 
It should be "RTL8367S-VB" instead of "RTL8367S-V".

I will fix this in the next version, or if no other changes are needed,
please let me know if I should resend just this patch.


Mieczyslaw Nalewaj
