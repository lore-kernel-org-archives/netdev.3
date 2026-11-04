Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=66.163.190.31
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793785210;
	b=3sn/M/0YFxVTixTNRq99c7k0Gldv31MCmv7pd/P1FoWz4U1Cb3Q/HeCgsh2nUnvefHxb
	 rlmVE5k9VlKAMIFoAuvzOrq/Kii3o1civJe/j5rgyQ1nEsV93f9ZV++KCiEuCeGuc1lZz
	 t55y+pIFaDYC/YdyVPz1SpfT5RJIIZkKj/6dUNQ1/uzKk6NMQBiO8gfzT29jfsWMzgr8p
	 JqvSy+uBPT2qi97NSSIgAjJ/adoSJ/cZnmUpNfHjHfKWQdBaLyMNoLX/Fz7Hw5l3tEV+w
	 mIwN7drjKI547vnmateymPTzTbN8iswVlnJmwSIU34GkejNBPjLy9iqn2F50h582Eyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793785210;
	h=DMARC-Filter:DKIM-Signature:X-SONIC-DKIM-SIGN:X-YMail-OSG:X-Sonic-MF:
	 X-Sonic-ID:Received:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:From:To:Cc:References:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Mailer;
	bh=0M0yINGH08Mmxxuka47Cr2UkeO83GbsdRwXTj6J0JUg=;
	b=RUQSwLtm9CH/q+PBN8B1YEgv1t9w6bjiOwKU7kXGTlaD8W1mzoprzHKCOccCfYaVugQQ
	 wlemoh84WVHhjkNXHkYK+jyAJevuYPg22qMSvnKI/SG31RkTUj/weV2nbOPK3vpuO+0y9
	 FdLVc/03rxBhAy9hsTJ4/ksBivV/KmAeCg7nrH4asvvdMicZPdtbvJLgCKkzgTIU9xAMA
	 5BrgwtpfQTVIznlt5wyFDKbOZivDroMpJnH2u+mQV0sMNx64t291EkOOH6TeKskyN5MSz
	 BS/v4avS4dKJTtoe3SN6XXzDQiU+pm9vAOUF76fTsOKvNsFcC1X1ZMuMyvhFNrDUBRA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=yahoo.com;
	spf=pass smtp.mailfrom=yahoo.com;
	dkim=pass header.d=yahoo.com header.i=@yahoo.com header.a=rsa-sha256 header.s=s2048 header.b=sfJxv8X6;
	arc=none smtp.remote-ip=66.163.190.31
Received: from sonic307-56.consmr.mail.ne1.yahoo.com (sonic307-56.consmr.mail.ne1.yahoo.com [66.163.190.31])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34CFD606A329
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 09:40:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 34CFD606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=yahoo.com header.i=@yahoo.com header.a=rsa-sha256 header.s=s2048 header.b=sfJxv8X6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1793785209; bh=0M0yINGH08Mmxxuka47Cr2UkeO83GbsdRwXTj6J0JUg=; h=Date:Subject:From:To:Cc:References:In-Reply-To:From:Subject:Reply-To; b=sfJxv8X6EBVv2+TZ/mdXlGdC3uk0UArYGV3dGclSqZefDwPY1E0RzxMAOTU4yNGJx7GXQGDHau9erMLCeIsOe3OGZ+w/WxcZYYBGAu4VFar0lex+dis0XQC7wO4hhBGXY7qNsDdSk7oporUtcrVrwv8G0o0DY8LYgWLb3f1yG0PcDDwAH4Jhqct4pdgl+NfrEiZi2o4t4kGG4CiS/5OQ/WUWW3YvFa4yZhYVO0SkjMV2AOhVCtlmKCehEZVRPtHNHwZfYs8pE+5Agw42he9zSY4zSv3rPMY4iLbJVlo96QtO4MjrtkCKp0iX803pGAexK9Iwg46hKOan2pAjS9xP7w==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1793785209; bh=01HHmqQNloGtvyCow+xtFB94AWON+kVli7HvpKRd02U=; h=X-Sonic-MF:Date:Subject:From:To:From:Subject; b=Y2inFJ1qaC5V2sgGrtEq3TXBNb3+FR6fpEzvCG8eh/5SGNBqH2oJLyGmgtFPPH2u3mqQIefoThMxgnhPilAKe25Ti9wTaiAneCziW2mSQhBS0o3XPhgApUML0YS/B76K6xL3SevVgp1lYt2K40uhDtmY4pbtWqcGjGjZ6NXdqKnpA1mb7GWVOaYlUX3/80HN3gLKO62ycf3YI00svM6Xfc/Ja2SMsiatN8pz7aojjYYdYHBCFKpb9Tiwub2wS3djWQFkNN/EtNVvQIEnRYuz+a2qi4H863IZe4XybiRad2+5jz9r1bR3neW1LfeHNg+JwZrWl41AkRSAAcHJG5cWSA==
X-YMail-OSG: L8TJw4oVM1nwLNGoDgcE0Vy2.1fLm3rSj0aQQ.pRdHQFfuMUGHFuGLh6MW8wq0W
 .HFuDOfZPLEnZDDe4dbWQ3y19tJDHA.LcBBsE1Ou.C.98eI9FAtMR7whGG2qfDmglmoN0IEmDsu1
 Y7dkj2M4VWRdm3HivWWWbH6bq6G.3cxQxyxMJP2WkUbAsQ1_.RkQux6Lou4FHaRpO7rbfq3h7NuJ
 pS9VB4mVhhnKnvgYAidK6mA49Bl9MPBg8jEO1.o7OV5DxYskb0INZ31HQjESGim8BtfRoXoSuwl9
 _plZ37ojSbJBlgxazJ4sc0KfBgQGeea_r2K2f7ic_5kT_JkOHZBAJNfnM9vaRjkWK6yNCnWbW31K
 bcUKz4EfaIz_pK02.6WcK1YYwQhuloOR2WDB0_etKvFwzUoI4iaCS.s7B6GduXIuSHyII8OAdmdv
 iGzsqdG7Bc_sxtPJV_5re_S82iyeqxV3Oq8Z.NYyShFe35khX4bWBdV746Z64aSl_qKSarcq9UPZ
 p1Jt4jGdYtweF92JJPl4zcffsIV3aCcUtNgBphBZGIqLk6Fvr.pUo0n8jXzuq8eH36boyWs6F8TC
 4XiWVVioU5p.j2xW3wjz7tnmUbRQB0K3zVf7umx2c03HuYNKcnc6dM91YSJreg.Du.KxEez4Fx9B
 _ystvgAQtVRFwE3xKp.or0h5AnVe6R6e.UFW0FavkAh_4L6.23bOHVAPWHNBhVtuWpaEmHuu2D38
 ClVWyxsFSHshMy39fKMB6nIJxO.sfJxXahgZ_5bbWRR4Klf5Ek1SRNUaajCgRotYD7Cq.EV5WL5w
 wDV3NA1e4HoPty5g58Q.jRAAvWz7mAVTIiXiojKuLEZJqsa07DX5DTu5goPNvhZ0scO0wQB_7lWl
 YdRd3Q1iRb1CqsH8fusqm.xfNYSrsFlaeuEwyQh1ASS45GjV5qpGaYHQPphqK5NPICsGV_hkzsGY
 dv.UplVE5v.G6Ku9khVnzOCBPpTSu1rRubgSlXSFYV.Y0iJHF85i2zysZaJeg3BCibukdKDQ9t0Q
 KrGIXFyW6u44UFN.bYooiP.zX9cRQF9sEx_WhvYHXH5axyGHP3FJuIFLyeF4tAox7Z7yMxmeS21_
 s4AexbkvwiPcRHe_1szaRlh3Zu.3jxvif9iOKUf0v9AUWGm6xZrPaTGENx7HUqzY_xtOvxgbOKZ2
 7Va0SyaczXc_sfijTX_V9xxh1.TtOFeVe8qIHUcMQbvhbhgFCFNMoGA233JQh3dRTFLwCeA.jRvr
 Q9Nb6Q3Zouv_tAqoM3u5ptM6T87XPq0QlUh5OUT.xN34VjkGwNgpBIZ6azoRphMzpWft31gD65t3
 ZEqqhSIcq8D2jWpULDjaUVacgH7Q82uA0GFgILcvhLhT7pphmqSKsu7va6uDP_j4JLA18t.unRBv
 dN86sSlTrGOkQoGCRoG0DCbGeLRqXzyUPiLTlIkcN.peSQLVQCAF_xGrRcMh_cfaNJFpO_6lEHHP
 7Lsw82jJE_aeg5XR0h32qdQ4nZam3fcTG1yC5PJhckZL9bhhr2TBdA629SKx9wRuierP8dYxqc2f
 7JtoxFyYzRDAUmfRd.NSOeL5FEGq4TU9zRCrK460cc6PYABVp7uemh1WTFdXEApy_lCaMbihR1Jg
 itPdS7svj3Os8SOtuSy3GPkxTPApCAir89Msa7KucshOBh9F3H49ihirnQ1he5oXZ8ELpYRKZp6g
 I.XryDPWpK3vD8wJxw1ewGm3u0mFDagPOOAy3FKoUrHUg.cMZf_iliAcy4O1IG3HUsRI9.iPaS8G
 RdUBRFUa_riR9b3jEvshUIA6eozIZ2bJPwuXJvpJzRrwYkZyrBbZjBzevPk9HD6I.h3gdkaisRoH
 QMal74ty1ulRLAzZvl016KWnnqSxTXCHTIkc0hIhW1CTVJP.qf07pLxLuqHI7hQPBOXHV1QuAFRn
 nX18xxsm6p.PaC9GeHxRX0HkjMMBS.6ldw9D3JMYtfsHdtMTXuZb6u5mmV_IPUomtH.bO1z33UqM
 MNj65YvaTocA.WLnomE31GE1UUSy5bihpl7EISD3z_tevD2R3umxOwE.kiewDJ3cYiaE4H43kxGy
 D3k.e8c9MXLVpi9aExG7TAaAdn4KOUkMkiWpuCydwVYEOjxe7ko4xZM2bxrhQKuCLWSMqAGevFlL
 pp.pdROGnFXw5QpsvumKXsjJ480BXFVLnO0JBope8JonX45aTx5m_SBHU5JCih6RqBxEAR4iM4A3
 Rtjbx39yN_G__RMVCEPY0vayfHeD.HGfpBNC0ZCZpGQibG.H2czcgBp.rj2hKsBNrlrlqPZGYf0n
 cYGeU4MBZJ1K26xp6_DVWJ7uu
X-Sonic-MF: <namiltd@yahoo.com>
X-Sonic-ID: 4a983934-1367-4ab1-bb45-ee1417ec361e
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.ne1.yahoo.com with HTTP; Wed, 4 Nov 2026 09:40:09 +0000
Received: by hermes--production-ir2-5dd9bf4598-nbdmm (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 7ca3a7e8fdb7da374483454663f3396d;
          Wed, 04 Nov 2026 09:40:04 +0000 (UTC)
Message-ID: <c353d13b-048d-43da-987c-3b83ae6e19e9@yahoo.com>
Date: Wed, 4 Nov 2026 10:40:11 +0100
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
Subject: Re: [PATCH net-next v7 10/10] net: dsa: realtek: rtl8365mb: add
 support for RTL8367S-VB
From: Mieczyslaw Nalewaj <namiltd@yahoo.com>
To: =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alvin.sipraga@analog.com>
Cc: linusw@kernel.org, andrew@lunn.ch, olteanv@gmail.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 linux@armlinux.org.uk, luizluca@gmail.com, maxime.chevallier@bootlin.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <3bf4dd70-9771-497b-8c27-e925e0ef81eb@yahoo.com>
 <c7f88f0e-b174-4715-b148-5f9a2648bc2f@yahoo.com>
 <auph2uJLrJ6Nj0dh@analog.com>
 <6c6155f0-0431-4ef9-8067-dbc104af710e@yahoo.com>
Content-Language: pl
In-Reply-To: <6c6155f0-0431-4ef9-8067-dbc104af710e@yahoo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.26871 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On Wed, Nov 04, 2026, Alvin Šipraga wrote:
 > I haven't yet had the time to look closely at all the patches [...].
 > But I'll try and take a closer look tomorrow and point out where else
 > we could improve in this direction. I hope it's possible to remove
 > most of the if (family is x) { do something } constructs and keep
 > things flat.

Hi Alvin,

While waiting for your comments I went through the series myself with
that goal. Per-family constants and the L2 serializers are the cleanest
case, so I'm taking them one step further than a num_ports member.
Instead of adding more members to struct rtl8365mb_chip_info one by
one, I'm grouping everything that depends only on the family into a
single struct that chip_info points to:

   struct rtl8365mb_family_info {
     enum rtl8365mb_family family;
     unsigned int num_ports;
     const struct rtl8365mb_jam_tbl_entry *jam_table;
     size_t jam_size;
     size_t l2_entry_size;
     void (*l2_data_to_uc)(const u16 *data, struct rtl8365mb_l2_uc *uc);
     void (*l2_uc_to_data)(const struct rtl8365mb_l2_uc *uc, u16 *data);
     void (*l2_data_to_mc)(const u16 *data, struct rtl8365mb_l2_mc *mc);
     void (*l2_mc_to_data)(const struct rtl8365mb_l2_mc *mc, u16 *data);
   };

There is one instance for family C and one for family D, and the chip
table entries only say:

     .family_info = &rtl8365mb_family_d,

 > The reason I'm saying this is that I saw quite a few places where you
 > have a construct of the form:
 >
 > if (family is d)
 >   // use family d constant
 > else
 >   // use family c constant

For the L2 code this removes the construct entirely: the four
rtl8365mb_l2_*() dispatchers and rtl8365mb_l2_entry_size() are gone,
and the callers use fi->l2_uc_to_data(), fi->l2_entry_size and so on.
The same goes for num_ports in detect() and the jam table in
switch_init().

Some places differ in sequence and not only in constants, e.g. the
SerDes configuration, the CVLAN entry packing and the PVID handling.
I'd rather not hide those behind callbacks without a clear gain, but
I'll go through them again and convert what reads better as
per-family data or ops. If you see specific spots when you review the
rest of the series, please point them out and I'll look at those
first.

Thanks,
Mieczyslaw
