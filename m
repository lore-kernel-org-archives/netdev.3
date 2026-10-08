Received: from sonic308-9.consmr.mail.ne1.yahoo.com (sonic308-9.consmr.mail.ne1.yahoo.com [66.163.187.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 565433EA957
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 15:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.187.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791472687; cv=none; b=pmASg9dvDQF9tCsG2Gzk644zvSwMzNL3DwWXhAIbX//1UujnwgHs1s/v5N0vjTaHmod+PnjeBqUMZLIqeXma6uOedZkFVTSHh9/czVcenXVCWTFVuJygQvkTufyle8ldhO/VVkR5g+yiSQN+Isn1WZN+HPZebGv7T5unSDbS5ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791472687; c=relaxed/simple;
	bh=f/wiRAdiJOaNh64TOWWc4NkVf6u4Pk76gXMZr1RLqs0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=k3I8sdOyAdM9PazfF1GQ1ZHocN3tedPTBJ1eLJLDCIXyjBHXYf5Jax5ecHan1zJopYtFE86Aj+U9sNru/OA6M3dQwDTAEqtvbgoG6Yrhh+enWRm4Ku5unwtuJQOg7BIlw+Kmjr4x03J4VKJxltbT8UrkqR2VLKdqvdsA0hEIXF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=l5UbjgJX; arc=none smtp.client-ip=66.163.187.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="l5UbjgJX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1791472683; bh=bqZ02vFEPGDtgaJ/nkEruzf5gv5S3ccF0CTYZo/fxJM=; h=Date:Subject:From:To:Cc:References:In-Reply-To:From:Subject:Reply-To; b=l5UbjgJXmxuTA5HlGwOQQew2PRTuEzn3U3UxzNWj2pPSuGtUBANteAxIFf/WgjBNegVHaJi/JacnUCoRc+Jg3fRuK8Xeg26VxecP97J22XbNJNdQmM6+8RcyeJCSWQetxp3pqcJQ/gZ4tD4mYZy0YfkK9AtRw42CeaeL4Ii2NShYRtf8ay1QdCLDuh5wmJwg/2O+90ZI8QACYDxNxYZaixH3M7YfwuDl98AGvtWyhV+4eCDly8csmfJ6LVvm5I978nAgWqN8LK6gmvO1mj28ysRHfbCWvsLo0/xveB6FSe7v3eZAnErxT9zgISt+y1q2jh2/c18zrPpzvEXbUWUXaw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1791472683; bh=l9NSYzVx4XzENld7rnQHMmfmWOlreaTQ01UpimjYST0=; h=X-Sonic-MF:Date:Subject:From:To:From:Subject; b=mJlEpNeupf3jCHVt/7UBAIRsrpg2NWLZooZXUc2cNQbz6nXFKpBy+Zp6fQ8/TwRE6v4dsiRZmymuCgZiS6qR4oGNzjC1pDkd/l3eY4Wu3OTJbiHOF0pu69uLbkbVGa36AhkX7cUpuZ9nbAelSLsXMdwcDRgoTN3mmA/nh35PEHSgP6m0Bh45CMU39PIrXCLXimxnp40fw2JX0+TmWPkiCTW9w86dhtuOBjRMMCNtD9X2IfTHHM7WqqRUEJuYbVZXdhwqUIB3BFtwvf76+joiPXWkccpUw7XzUte2ugGN+DRafYhA45EHNQCDg1Yu4iCh0iBkmMpCeGn7/Xu5z29qKg==
X-YMail-OSG: pyFDNkYVM1nbBy8cB0UE0Jp.tZbnUBMtz2L_Q9J1n2RzNawXAJalTEW35EDGO7H
 cVvOrJEbey2szNAqdAdF_SZLc6mIVL6jrrwjKRS6q1Wxzd4kyf_tFyO6kecMxmMh0FZUN9TSZ1xq
 mRwT52k0naF0fN8cze7aB_0zCSOqelmyklZwqhEnfoOFHAFwVymmhtg3l5gyGgMyTjtp2RmmuEyZ
 oMqgevpjX57toShAdXv3nXbixdQzjXextO9pC0ARLqdNUpmYqkE6v2JhVxzLaCFc8jfTuhlPnhEr
 mcxjXhOyVEAaFt5InkZ3bj7p7ipxwykbBiMeWamqly2D6OCbXj4M8x5_QOzcmGhlji0DBAM_ucJy
 QwbGo8gkNR6lmd64e2V6QHicR4Bntz_w2uuooIrhai5ls3VVP1typvgxjbJcNRVg_sjdVIF4W6lX
 _o5em9252miyLkVPOocVE.87PcglddRIGWQ8xbkfDLf4lIMcKhPqs_WF5TyVTtJTVvE1ieu4iQ0T
 Q9aY_2d6KKNqlFQ1RoOVtF6l2UnM7OaQwdYEIObxzp_e2W348LWoVDuUFQlsg0YFSXWP6PYS_W3r
 d6rawFR0go_BPQB_dBrQonEmUJszXOD2MTRZ6ERykYfkMGBwErydyDrtmheHppFsT4qcEMA0uPbR
 UOJ0EP5I7YUwkHEbTtxwwIld_hsseG9A2h5g7BDa9YuZjMq1zNbn2UoopPkNEq2fEaqtUg7takt_
 Pr1MjrIDC38qDMPuAG8ilMvQezvo4.OBCsTHD7cbs_jsxGRjbA9qPRqo8gLPM6qf1dQbtbWRx42t
 t9_u_jiDT1PAgbTLGiR2GcmUt7rkyIpT.lGK3vaqiK44HRjWvMQ8SHT4kIljhD.XPTcpZgld5Lld
 8O7DzerSRGz6LViu40tnVRVUnDnIFEskJI4Fmbju0lKQMmwwCXguKEb8znRQRmU3ozcnpbDLbfFt
 Q2gYme871VkoOVHo7cYEzQhu_TcJvZJaX1HYaC_lv0W.EeMpIZPftvr_qWyTZnUlHDbYlTt8BoQJ
 BPxaFqGM_psfV82QXVyyMWVc4Sl6HfVBcmlKl_gmzQ0y5d_15VcHwSzaFLXiC39HXNguy_YkxQ5e
 1iAWISFc6WNbsJhMyWF0R..Q7pDb2AOc_hR907fVLXX96cTQqJ.MjDgh6MUDmp1QQNTCViRYk6JA
 9fcW4Q3uIWwsgyUKiLs9In8E1BniASu92MXvsJ9s5FdUfcJSC4JjgVd7p.gxv7_zUiS_c6PLeD6h
 xr2dmYmSgpjf3Lz0KNGIVCcVb0UGrRvOPOYbqlbZc4A53wnqyM4h.C.Pcr9ZwYkZMuDFxIbQuiV3
 1_EsXuXZgdPc.VGma0UAB4vakMN1aaPgyYtO8F_L7GTFxV3Dasme3dbvYmJDRLEWi2LyVhuIm5kK
 Z.3W9807Pj6Q8gUp0S38Kqf.ksE3kO6ohlPkb05vjaLlHEZ5L_XUXV.aYKqDgh9.NOyqTi10ZucX
 mL4Nv54my1ZV7Wf3XSna9qExGLHi9s3IQk6TVf2Dv02rUJy2cUzukpeEuViVArwqeu8aOLvPZzcO
 3loYmWGcU2SIkdyXqoiutiIgvmiTZQ2huBVHoIKGwN21yd..Dxl3IAqYMJO.P8nzbVq_n7NNPRO6
 V.i5qrn0KriQSQh5a2LcYOjPC100YwoFSWG74rwMkfpzsZ_dvBSiIjTrkBj2KTYgsLmgGJ0lgw7w
 HRd7QZsHii3rnw7Ypr6sXaMYJD5pcAxYMvAcKlFOj0auxLWmem28THoa2Nb8F_Rzq_P76JlnIFGL
 ZlMjlPmfBhIrF2QBNK4XU3a9wuajUSpAmv5krXZQhAVMULK6ZD_b9_5Zoj8MZoLafYzc54TRlZoN
 4U4MEH57Xnlo5NNBR1ZzHedU1lhSuXN2_YtVHNDIiZMKInW.eC.tGQJx6N4a0RzMybGz5wK5DONc
 IN6Eao8o2h.IknNdjJHjQDjFWRoO1gJHM8zPpnqBdyRw_R5xVIVFOwcQmGdvIGQmE_CvNZZUt7kA
 _m8PATA3pYDBiG2WdEPI9NOeA82MxorAnfB2cRKJ3tqKjC_r1U8ZPRi9vYuXei713DqKQ7nZcIX1
 4huZBSj9FTl5i77ywsFRpMHVZpObkuqXf_kksEGyxVBBjHzPqeeH3B3_ZVNFGTxLygvqI1cZs5wC
 QJ7nKpNBCOfBe5cXJifYBHM.3vBfsPdXJCTO4LZplBUnn3XXb31dssxyUjJsKY9fimMYm3hRIEy1
 tAy381THakKg0otHlKmmeLY4Xikma_burKdeKcIEauADnMpDjYeCSg9V31LMiT2.LQYWVQu2qQGl
 _R6gixpG9jhR6SEwpOT8Ton7pfyGYFerIXvqXfza2qoI-
X-Sonic-MF: <namiltd@yahoo.com>
X-Sonic-ID: b12aa3a1-130d-46d2-bc72-b7633dcb8303
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ne1.yahoo.com with HTTP; Thu, 8 Oct 2026 15:18:03 +0000
Received: by hermes--production-ir2-5dd9bf4598-c2rmk (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 46a763abb20b372b1e2d53c07276f718;
          Thu, 08 Oct 2026 15:07:44 +0000 (UTC)
Message-ID: <058a5e14-76ea-4c88-bc52-f37e3e502a92@yahoo.com>
Date: Thu, 8 Oct 2026 17:07:41 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 4/8] net: dsa: realtek: rtl8365mb: set RGMII mode
 for family D
From: Mieczyslaw Nalewaj <namiltd@yahoo.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: linusw@kernel.org, alsi@bang-olufsen.dk, olteanv@gmail.com,
 kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, linux@armlinux.org.uk, luizluca@gmail.com,
 maxime.chevallier@bootlin.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <84fc7483-b22d-45ea-a3b8-3285dc357265@yahoo.com>
 <dd78e00b-c161-4915-a917-3b5694139621@yahoo.com>
 <eec36c89-b6fd-405d-a951-aec0677b149d@lunn.ch>
 <fdddb05d-f733-4b28-9442-11adf7223cdf@yahoo.com>
Content-Language: pl
In-Reply-To: <fdddb05d-f733-4b28-9442-11adf7223cdf@yahoo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.26668 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 10/8/2026 4:09 PM, Mieczyslaw Nalewaj wrote:
> On 10/8/2026 3:22 AM, Andrew Lunn wrote:
>>> +#define RTL8365MB_D_REG_EXT_TXC_DLY				0x13f9
>>> +#define   RTL8365MB_D_EXT1_RGMII_TX_DLY_MASK			GENMASK(5, 3)
>>
>> The current code looks at tx-internal-delay-ps and
>> rx-internal-delay-ps and programs some other registers. It is not
>> clear to me that the code you are adding here is correct when combined
>> with the current code. Please could you look at the delay
>> configuration.
>>
>>     Andrew
> 
> 0x13f9 is EXT_TXC_DLY in the vendor code. It holds 3-bit TX delay
> fields per external interface, separately for RGMII ([2:0] EXT0,
> [5:3] EXT1, [8:6] EXT2) and for GMII ([11:9] EXT0, [14:12] EXT1).
> The vendor RGMII setup path for EXT1 clears the RGMII field [5:3], so
> this is an extra TX clock delay next to the TXDELAY bit in RGMXF, and
> the GMII fields are not touched. Clearing it makes tx-internal-delay-ps
> the only source of TX delay instead of whatever the bootloader left
> behind. I'll say so in the commit message and a comment in v2.
> 
> Regards,
> 
> Mieczyslaw

Hi Andrew,

Correction to my previous mail: the bootloader is not involved. The
init jam table writes 0x0090 to 0x13f9, leaving the EXT1 RGMII TX delay
field [5:3] at 2, so without the clear it would stay on top of
tx-internal-delay-ps. I'll say so in the commit message in v2.

Thanks,
