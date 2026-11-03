Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=66.163.189.83
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793724262;
	b=S/hcZtmxpEKPWutL5oJL2atRgBwtIcFUTS528i15zBRq4ziJSKHTKKA200eTRXok32gx
	 XpRtktx/BHcHwCjclwS0KM1SdbX2TYFT02yVODh8AE+pQxq1iqeENObV+9VKWT9tmHEZv
	 XFW62IDco3y7oSJ0tptNAKgrDnUOJ1QWvAf1xW9wL/dr9cDiwmduh01t1lYCvVkaJ9CY/
	 vaw1WWSKCDbbMR/P3CQFZcNp35Twpx0FWBs9IN88TEfuurowAhRmwJ5X+ldVbyLA1o1Bx
	 xFKHRPR7IVf4hXk5/jnYJSwvFcmaEqopVuzHIxD5iUrew8yOPmhpTLcQDY/OvwJCWbQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793724262;
	h=DMARC-Filter:DKIM-Signature:X-SONIC-DKIM-SIGN:X-YMail-OSG:X-Sonic-MF:
	 X-Sonic-ID:Received:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Mailer;
	bh=jyy+eSHMGuhG+ftQb5hYk8nR13XKGdG8SyhmUryqcT4=;
	b=ttD1AinfEQjjVdtBG7F+q2oEMhKCoZvIGvbpnXW8damMRKeT2DG1AaOOf0mBoM2PF/1i
	 /RKI9Qt3aIgQfYO7IuEPKuBj5j+oGPcbcF+BKZhYJfz0vYzaSaBNkppn1t7gBbOy3DIqt
	 XLjJ3XIfDM9099FkzQtXKCCUVl7VP2BDMFevsEBv6GvI2LnMG+1zJUWugHJET8BBt4c5p
	 U+tn3BDvhhlKTvsScwQ6BVCIqQRudQz//lXw5msLx+ZD2jG6rDlj+6exVgxA/1+LkbkvB
	 P5ExGR3y3NMmvk2eKQ1TXVwDrJDTfTV0rrgpZ8mzw2nvUU308evbyEszOMBN3VLau7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=yahoo.com;
	spf=pass smtp.mailfrom=yahoo.com;
	dkim=pass header.d=yahoo.com header.i=@yahoo.com header.a=rsa-sha256 header.s=s2048 header.b=Thq8hG9X;
	arc=none smtp.remote-ip=66.163.189.83
Received: from sonic306-21.consmr.mail.ne1.yahoo.com (sonic306-21.consmr.mail.ne1.yahoo.com [66.163.189.83])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E80C606A33C
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 16:44:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3E80C606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=yahoo.com header.i=@yahoo.com header.a=rsa-sha256 header.s=s2048 header.b=Thq8hG9X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1793724261; bh=jyy+eSHMGuhG+ftQb5hYk8nR13XKGdG8SyhmUryqcT4=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=Thq8hG9XOk93JQlBoZ46PObXmMtgdBEERfxGLovKtZ+J1z7IEKPXMTw95o/p71NIRwQzh9mSFxXABIjUzULOlDaiNm0BYL9erEA9CBiffRC8xB7Fup5I11wsR6ASgxUlo5vtmQuke3auidjmkJZLSjwwnnm5rjaIMjkvrAuNdPlnjHz+dC8E5phObx0v7t2EbOSPbTG1ETbjPgixCtRXZaC+MAboWjYngdmvtw5AC6RexqiKZCjcGjsW/bHtbFL9/P6QJ3EbaKQ88Zbonl7yv9wXnR4V+WPjcXkvgr8548afQ9wVoBa35i9TB+RWBQZF2FmHz/b9xUyBA+EnHwarOw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1793724261; bh=hB1QUTPGhFbf/GBgOAyAZVVD0NFsmoJJvJILLQQ9udm=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=Et+akbQe/QYmTLQKgWeSEXrSrYi12uof3HDl/K8vVhV3uCF6An+RbuhmSWXLBsTE627AOn4zST9kJF+dfDYjfcubMV/6jxsaJ0WmMDPSybL6xNm2/5Ld6Np/wq46Gadx+g8tnWjUkFIkmRVz19ms7N4SIRT5pxUVoy2G3Dj1SZZqpiX1okxae4JQH3lcve5bAD54s6okOwyCjEXXWJYuAzkMjo9r6Bsfb7o0KNr5AwajFU9oxSnE/7D7V8lRjKUocOPowjkFrSWmwLS8gmqmxUnAtb8f2rSnvj0toJo8tUdf7MtNJ9Xvult4fMMY3fzzsLnMbC3zNxmSue0PqZivfg==
X-YMail-OSG: l..FRJQVM1mnMJuXB5y_FH0Fu_tmU6saHxXg2x7Czbo9lqidiEXIHJOpPyXRVQ1
 2GyFGFDfVCSDBGrZfLKqYGvfczlPkKaUKxy0zO6mUStBXIdlb9uVv2sfIs41UDBGCIbvSF5dDIvE
 8P0JbpK1iVxgJeH5jBzOjHlzvOK0aJar4wVKU0Y8FQ9yKqSI3CGbpn1C3mvr5CkGGQymNgeA9R9F
 ocUCUONKmLuTDXH0DdHTYnUDanWb1PBsSnDr427gG..nVPf2rxzwcu0l709rsCvYHHkRVbyGF1x8
 ZBEJ8qxg8_RZR5zu0M9H9oeD_pfh2t8Ewsf9aXtyfPx1JLtEG4asbJGJ800PvtZeyUqZMkT7JbUO
 SVYCCVbZzc4K71nLzMkeJjWkXTSYYHVULGv.xi8sJPpGAAZUd7yB9Gwqxe5hyTk9yGyxy0Bwoj_D
 eG1X9oFNW8WsQ9rUcwTPUttDl7BvVcfNuwIQzjvIHF0oFe185plwB0M0c1vDd_pLXOOFk7S6B3AV
 kG5afEaUSe13uq_I6CSGoFImQy2JFyJE5sNJvQG4qGSG5hg_YVbuv4d.p1N5HnJKzlnSKKJ1Avzh
 R5hbJHOKugWrHmOId2SG_dPkD.Lf6Ciu31st7v4tMvwnkwGFxWOxvLeiyQ5LZLfLY.UJMj8H4fh8
 NQWYlMaohHETyiykK1Y2eW0osGwwXr3Vs1DDnSgAi.J3V.q3ImPTkRNkMUId9miR2jgd1D4Ba_nF
 2QQYynaMU1YQzg7dPOgHJFu1Kqr8FB_2YroINuuPfXRolvpSR8SDmJk4C_uPMhkoXSPuKlD7VxJf
 g0zdyYMM7OSWVbpIlb8ehApJuWgbOMckFLVLgvy62LsTQURwB7kGzCa3N41xpBfly08h.hKW8603
 evsyFjStogIUHK0pliXcDQGjAi4Fjx9etpmsJ20MICwgB2A6jaeCXLhkYFi.VZq2lWnvshSLZ7wg
 FnyQ8cDg62ECkLGwz1OJDyfBbWZZIEO8PbdZxW9sUT9OtJfXK.1uFyVPWYYBTDnboiunDFFa150t
 yKAVxxMXMcGGtiwAYC_ubs1LCNTE4fDk.8OFOyN8JTetRT86crYrXuZcY27wzYGrySatVFuZT.Aq
 2X4tyFZgaAxApZupfbOGaxx38HnVzNUV4x9T0KvHafq6ZNIfeoNZsnfKXIhqmfp7BkT53ziqBa7Q
 IDMWZfh.kVdVs2fJ9gh8XGsfrFsTfuxt6YDERryS3_obNewFRg0ZEVT1ia8D2AGVtc2KTrr4QBUW
 Q1O5yaromVBIz21CxSei7J6tBc4.jRycAUW6yk9TZMlCqZSsMZmt9wgvsXcALhrn.Ij_3faVCnn4
 jIRuyAhFW0qFlMnc3YE0pqoLgaRQiIvqEQ41OmYhCAsFHxeOFwJHuLQMTxiE0byOFtDBsWlTO5mR
 uTF0qsh.1qOYsLKDVFa5XFyP2.02acjBvH5n2WNl8oXh7NJ8_Ol8jMo10LTuPon_sKeagIjED9wm
 dus2m9gjOWgPWzsR228Pbh3kwRhjuXhAmtR6zh8E6zyetjmP3.dPwrGHYlMv81qFV0s_iP6BzJ1.
 VxBqNqjvR8m7UsQPnUeHMqQVvqS0XBVaV51m8ASGw_wHkgAVuWbcEsJN_BEj9eZWGfez7086zKNz
 sBfj2MkNtJIEP4QOLEbIJ.0SD8fkHuRIkfesSL33Aki2rw5YS4oU8tXBncOjaviJfwHVNYOOtfAW
 dUIqY8AxUJpkg5Mx.lYQZi4gAyJOpQePLTVNFUt_m7AYaOmBs1aiZOBoDFPFbCKcm6z18uPRLs3R
 9OamMoPY4kwWnF5SrM3qpQrrsr_WLzNemFII3YyfcJWcbhtc4pu4E_MUBACH2bIPFhI2i384balq
 9YZHJbkCI72K54ooomho371v_WjuaDUbCupeDi9E1o0b2y2n8oM9XviZZ4v4..93tUJglCTGH.9r
 nqZfTFK7g87o7.95UMW5V7BwxpfyMftlrl_HWjmB9_5fPM7BqWdUYzz.OcavCgwyO4VR2pyy3KAW
 LzpWv1lUSyZ7RCD3xNeYJLtNNtJw_EkW4H9pEGUs3bJFI3tSvMLBHYuGoaRLipSip.bU1nt_88uD
 8.TpcVg78CD6.b88HuJsGCSFHZLjk1F4o7kFyLl0MQXl8FvLs6aLZ4BFs2wiPJ7yYnqORUWg6gUs
 zvQz8jaTrTXo_HDRq5NK026P9i8i8I49vlClN9tLYbmP55CMj2dJIM.tn7TAccT9lmPJLr6.9Liz
 jti38Hc1F0fZnKruo.YXln7gFzqfAKGelAwpGWwImldSrHihJKrLG3E3IALr.B.u4N2fOdTtQ.dk
 sHSJjKo7Ppz.exOGVHBaJAK_yU6lYoewxbG83m6gb
X-Sonic-MF: <namiltd@yahoo.com>
X-Sonic-ID: e3d0571c-efe9-46e3-9d38-9cfdf6596b41
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Tue, 3 Nov 2026 16:44:21 +0000
Received: by hermes--production-ir2-5dd9bf4598-ztwl7 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID bc5603c53169c994bfcd0e22eea35b18;
          Tue, 03 Nov 2026 16:44:17 +0000 (UTC)
Message-ID: <15ba8390-45c2-4f45-bafa-212a129d2410@yahoo.com>
Date: Tue, 3 Nov 2026 17:44:13 +0100
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
Subject: Re: [PATCH net-next v7 09/10] net: dsa: realtek: rtl8365mb: make
 L2/LUT access work on family D
To: =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alvin.sipraga@analog.com>
Cc: linusw@kernel.org, andrew@lunn.ch, olteanv@gmail.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 linux@armlinux.org.uk, luizluca@gmail.com, maxime.chevallier@bootlin.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <3bf4dd70-9771-497b-8c27-e925e0ef81eb@yahoo.com>
 <88239c31-e161-4623-8dbb-db39f506af6f@yahoo.com>
 <aun7hiSq4MF5BXOc@analog.com>
Content-Language: pl
From: Mieczyslaw Nalewaj <namiltd@yahoo.com>
In-Reply-To: <aun7hiSq4MF5BXOc@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.26871 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On Mon, Nov 02, 2026 at 03:44:36PM +0100, Mieczyslaw Nalewaj wrote:
> +static bool rtl8365mb_l2_is_d(struct realtek_priv *priv)
> +{
> +	return rtl8365mb_get_family(priv) == RTL8365MB_FAMILY_D;
> +}

On Tue, Nov 03, 2026, Alvin wrote:
> Shouldn't this be a top-level function, like rtl8365mb_is_d()?

Yes. For v8 I'll add a single rtl8365mb_is_d() static inline to
rtl8365mb.h (in the patch that introduces the family infrastructure)
and the L2, table and main code now use it. The l2-local helper will
gone.

> +static void rtl8365mb_l2_mac_to_data(const u8 *m, u16 *data)
> +static void rtl8365mb_l2_data_to_mac(const u16 *data, u8 *m)
[...]
> From the diff it would seem that this is specific to the D family, since
> you only use it in those functions. But looking over my crappy original
> code for the C family, it's quite the same is it not? Can't you update
> the C family functions to use these helpers too?

Good catch, the packing is identical. For v8 I'll add a preparatory
patch before this one that moves the two MAC helpers above the C
serialisers and converts the C functions to use them. It is meant to
be a no-op refactor, so it can be reviewed on its own.

> +static void rtl8365mb_l2_data_to_uc_any(struct realtek_priv *priv,
> +					const u16 *data,
> +					struct rtl8365mb_l2_uc *uc)
> +{
> +	if (rtl8365mb_l2_is_d(priv))
> +		rtl8365mb_d_l2_data_to_uc(data, uc);
> +	else
> +		rtl8365mb_l2_data_to_uc(data, uc);
> +}
>
> Can't we have:
>
> rtl8365mb_l2_data_to_uc() # same as before at all callsites
>
> call into either:
>
> rtl8365mb_c_l2_data_to_uc()
> rtl8365mb_d_l2_data_to_uc()
>
> instead?
> [...]
> The above comment applies to all these _any() functions.

Agreed. In v8 the existing C serialisers are renamed to
rtl8365mb_c_l2_*() (in the same preparatory patch, so this patch
stays purely additive), and rtl8365mb_l2_{data_to_uc,uc_to_data,
data_to_mc,mc_to_data}() become the per-family dispatchers calling
the c_ or d_ variant. The _any() wrappers are dropped. The
dispatchers need to know the family, so the callsites only gain the
priv argument.

> Even though family C is the originally supported family, I guess D is an
> equal citizen, so it's good to keep things in this driver symmetric.

Agreed, D should be a peer of C rather than a special case bolted on.

Thanks for the review,
Mieczyslaw
