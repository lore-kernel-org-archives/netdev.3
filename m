Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.227.126.134
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793954510;
	b=jSzSvWdGJuztwn9Tm71VRXxWy2MCKOS3j8MrhviC/ZcPFJ4HrEfj5sUAD7fyorqJzFn7
	 zmWVARKZT8lokjCJFl7O68FjjrlGIToreeerMocFUa2IbqmhsGorya67+zkU1wJS4mJMA
	 3Nr6GcmiUbVNUgBmj4yxESyuJ0irMbgjWYPsLbmmCKCU0DndwQE5PsLnSm00XVyBG3elm
	 pMYWwbbkvVfF1CaC6bBu3o1Z4rR6QWPygN613iaOs2oqjFZI3bkc6JyLLg5Feo3T+kKgI
	 leThUTxNlaVllXSUnA1bF7pmuH08THvoGt5JOt2IZhsFrH9hVGPXUm4SOlhvN2VBIpA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793954510;
	h=DMARC-Filter:DKIM-Signature:X-UI-Sender-Class:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Provags-ID:X-Spam-Flag:UI-OutboundReport;
	bh=+Uplc5nnL/gjG62KmqsGkesQCwFHZzvrDygNx8tGsho=;
	b=G/wt6SZdQpw+/M5H/VFuMRdPZC6iZ1by76V8J/IGkq1BS9krQ8bkyCy+KTT0sa42PX6+
	 Mxpcu4C3aehez7B7l4C4Gabu5jOj9Fzu1IiWtChVnffTf33BZHSp6MBsNE5Et79rlVb9k
	 KmCCYR2IAQY9bS46tygABdfM4MGeFqhHmJJ5k8FGY62Hw+86F7txOn3BnQFvLsU2bqjgZ
	 Sa20IcOsgaVL1rYwOKsurKiIIEl8SxnipsGuwY9T1QaCZyz4jQVJqy3unHSM6Wml0hm33
	 FfVRaREvbYWogbUd3vP2fm7YBpfXTqP67KHtSrnbiykBh+xI20pPXKJnJFwrTDitY3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=jonasjelonek.de;
	spf=pass smtp.mailfrom=jonasjelonek.de;
	dkim=pass header.d=jonasjelonek.de header.i=jonas@jonasjelonek.de header.a=rsa-sha256 header.s=s1-ionos header.b=GQL+e3pm;
	arc=none smtp.remote-ip=212.227.126.134
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35EA4606A326;
	Fri,  6 Nov 2026 08:41:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 35EA4606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jonasjelonek.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jonasjelonek.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=jonasjelonek.de header.i=jonas@jonasjelonek.de header.a=rsa-sha256 header.s=s1-ionos header.b=GQL+e3pm
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jonasjelonek.de;
	s=s1-ionos; t=1793954497; x=1794559297; i=jonas@jonasjelonek.de;
	bh=+Uplc5nnL/gjG62KmqsGkesQCwFHZzvrDygNx8tGsho=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=GQL+e3pmXim64ctIBO8usLf0+Nznni76NoHowK3VA4bXPVmyGNzDlMf3a20An1r9
	 zmeuD+KNSeLMDtK7SX2KMPuMmwadeo3MbYIUzC3GNpjgKPDfrY3PuAUppyr4c5Uua
	 rEpV/bi90tsYoVnREwkhbFZWPPji5rbNl6Wp60S/2t2g97fDik4GhjQp84CJ0rsg5
	 exVz73PgyY566meJSWc4Un/2987p6GC1zp/KdMrQUotb7Z3qxevtSrvdovy0pluzP
	 hqyiY/RMI0YW2MOiOCKwxITWAMbVpQINAoKFBec5dGJv6Yi6rWmydfaQ1G4Lm5yv1
	 qrq5G1mUXP4jtNJWkA==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from client.hidden.invalid by mrelayeu.kundenserver.de (mreue012
 [213.165.67.97]) with ESMTPSA (Nemesis) id 1N3Xvv-1wPtMw27Fr-013ksY; Fri, 06
 Nov 2026 09:41:37 +0100
Message-ID: <041c7f3c-92bf-4036-b404-c7aad959ac99@jonasjelonek.de>
Date: Fri, 6 Nov 2026 09:41:34 +0100
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
Subject: Re: [PATCH net-next 3/4] net: pse-pd: realtek-pse-mcu: configure
 global power budget
To: Sander Vanheule <sander@svanheule.net>,
 Oleksij Rempel <o.rempel@pengutronix.de>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 Russell Senior <russell@personaltelco.net>
References: <20261103220312.860629-1-jonas@jonasjelonek.de>
 <20261103220312.860629-4-jonas@jonasjelonek.de>
 <f67e328bcd20f405f2f15c62123bf3e0e740c14f.camel@svanheule.net>
Content-Language: en-US
From: Jonas Jelonek <jonas@jonasjelonek.de>
In-Reply-To: <f67e328bcd20f405f2f15c62123bf3e0e740c14f.camel@svanheule.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:At4oAOzU+N3iLkKVyqh9i4zJZsrb+mRQOaxzwY464TvVxJXvAjj
 wqWxqbY4tCzWBMNSdZYgMRgmhGUPvGQ7rrnbj8Fb5u8Ga2Oz616QsAxjWrCjhSndICjSiB4
 yOtEm0bv+2Y2M0qbU2VK3rPyHRkyHPh1+prFBlyK/PKmPyx+04P6ZKSygXMyvax4bXQjQAT
 bWbljbbkcARB1bhTDqU4g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:/7AQAkSoAeI=;5TFn6nAGprR//UzAme5GwpHFuiC
 P7Aeoaf8Jet5KHkn0LZ9lqu/IuFCDkh/n++Mylu+ZVdo7lUhw1Gbda7tdzTimmZmxnncqS8h3
 JsDrDYCoT1wC42egsKJm5XOrLPG/VvURGSTdxSO/2QD+MSL0DFzO3X3PEiMkoDW6YIGGU8SaI
 Hx7Kc5r7N3gIsq+uG0OAUi5N2dKt9ak1EoMuf9bTnaqHywuFsfr+jJYsZ77w4QCSid1q/lGiA
 IMix2Poa8VFXxL1Wll3uwpVo+29oahGexbIeNffBVh2K8uKpEfKZd1CZDi3314g53rKoeNhMN
 aFx5ZURFd5wDZxUuS47KvFcsa/Y3tv3vhtfYVu/8Im+CGemH7maFDtc/cizzbZUsASKcbPkI2
 210uoNHyxKYrVe0d4k3VcRqBy8/szZW57qEVNMaufZX2/U9+oKDfbSj98Xo9u9vMkbI/7K+Nh
 bN6DTpvdjLR7MtBYeGs6qDSLJ6LvNIPQE8ZF4+Cln2crHoRWDQ17hoWOVDYEuv4N3EUu+T4k5
 PjaEO5u6KPF6q1QYQBiERUVemXuqTOTVG5Oer55BamwNXWc827xyBvs9UZ4S0tHHU9324yLkK
 cgxfLX7XU8H2D/GzwDT9Sm4y4Slt6qBFXABVsHwCq2NPmBmUHFHIaBisXzioCU6/1WIjR0JYH
 V8/ShdfxTV+X8AqwyTD1ZS2gwg7BB0JpEtzAm5iLkbWkvOPV8megOyuP05o6qeLVp9nIbDU3Y
 QXV4bPz3ebbMAbFbWLt5//TxeQ/Wjgzjqinid33qoiT2gg+hM6Z6loXrkgIOpjFAL2Be83bEv
 1uscJ8cBXyQ9lItq+CYC5mc/+du46mU9HcZlsaRIlsrUF61hcumWkMdWqpDtcRvTpKcBpdmrE
 indKMoopJeQSY8VUkinkr/UQmInS2JH+D0waaCnrSo5RfrNdAMu+nVCTm3Mr7H2EYz8MzqiJD
 6EQN3lzrWut3xsmg7i06VOAyRsbQz1LMiHlRFP1rJaLn9fB5IsTp9v1Dt4Od5R3+uBMkvSurC
 jOgwLwbGfThZu85F1tB/YtTFf2Hu7Z4l1J3WyxDRP1fK2uwEQURC+VUGDsDk7iy8S+RglI3oD
 UL/CTc7O+GCzhFORrkwWYD8VONW9uvE8fyhP/wQzSIKsL0+quvads9knBMnzyUnyraxWGtea6
 uqihC/M4xP0eoSohPWUIzpp6kXxa1ufJtpP9XpSVbni7qbSLtyyJA0gY0bO5mx24M+C8YzN9a
 rFlMwj4x8dmw01/JfpW+swieI7zvKtUrqeIM7tb6Fqi9e+ALNR6/vNbc7hAz92kzxSX+m/cWQ
 Eq5KYTo+/XkJocvTEIQ6RrpSoaRQI1gHFmIq63YhrTPkcHrGz+l2HCD7SHypp7IV6+5OdD/8X
 32S9MMxFtphqDBMmcmXpEmyxbF5O5BVym0VHUMP/EA8k/98Ku5mbEajVYmnw8rXuVKyLDFXoF
 kpIVStRPOnCJEEtsEd3aRcvWHWtC+GJ7TgHqkKNVTSSQerFkm4Vj3l3lFDlz+IdsG7fZnG981
 jRWR7AlbyUCYNctEa9iXo0Vg34gYv6w1XTcvQuB0JZcV/k1kl2JJ/ZX56JsHki8APDXX0OHuG
 ooys0ndvu9WHM+qhoyngmxpJZWo9qvuZVFV2Zedr83DXT27nVbHrcv6sUQXCKnXvTlkZBfgCZ
 XoKKOWcJFIkr9r/x8OTg1AyX3v5NwmC34fF9qiIg+vEGxFCq81OVsOGPU7sjVu2QMrBHsDXy6
 goOFdrt/vYkoddu2/Ct9/o+x85xX+nvFBXf3RvZ8NmXPqqXEctbOaUk60ZoIGLGB9kB881uB3
 3gf1k+ZW7Q8nTdbuc78TJOsv/pVNNeQMjbM7/VPlUhzxgllBjlFpi6+5xwaqlQprHz0fD1vHO
 wgicuypkI2wpfec/7CrQulGSDMMOjgRU+pu9VmvEMjdkXBYD45mWTiJqkVaqhq8XDCl6hUx8D
 UjtC30OnLpfDNsU1qo8qGqC9iKKjopJUK3o/OkgV1v54Gxb7Ce2BD0QSFHJCYykMTcwwdEtGz
 XnUDOb0w97cNMeoyk5Wja5z/6RvDHbDFKIltgqMPm1CH0+HzeVFYAOhroFNqjXsuitsSkOQGB
 t0KNhHjqOYs6ufDgSIKJaMxnRhiCnMg2RcXPsBfBUWHz60y+OR3tPWFoGLnngv6MgfhsULXVd
 GoBIdJeH7Y8Vq2LlI67WFYQ4uX2V1Ew1xc5Pe/pVbGNm5A27QU/JgUtUPuyQr4tQjgAOMPcPs
 s2JJcwvnys13w9PXss+gefPvRLB1wxiqa4Rwff5wzB8o5VIToMFy579/xzzJoEQdI3LoxdqGM
 qkkHkHDB2wB8WqARj/axE78D6SjOGcXFWUJa2WKpE/XhHxQtV66B5aSpz7T8WCyL4nicvrTv8
 d/JqB100RTf2QjyOwOvzhmoBG8DA9FDtKvQtKL8BcfIa2ppwBUNzxNFffNJZTybdXXvJ/d0za
 IRocMKxN/Rl13tAEFdXQDiQQ9Tt9FRBBqC4U6he+4RKm844vObRCYQyw0uywZo0my8GiXG9L0
 kMXQbhSrqyO4dsrqEmY4qOzEkGOa25qvSp6vBgLyd/X1vs95PKrV/VEdaQSqUxB+/HJoA20jw
 IlugLw5AYosgQZMnP9g8AcbZCUowaghoUOIh2jMHjgsKNqHY/wAQ90EIwcPFaI4jQdihjNmIP
 cssA71XzNdgkv1ROVtlifepnMx6/VZ+6KrdywvKMhHwasAjAwmPLblTnJeDHB1Rrx6ruop3cV
 2A/jsHTuZUyqY31xIzQWd5S6xUTcZvGUWVtp6bem7hfnjjDmkMQQzsYeY6TElEwK8d4plm1X3
 W9j6nB4WpIrdE6pei/nf3Hxryd0XwT0a3AGVC4R0N5t776w+A55xXk2seX/1KGfBklmBpljmh
 Qn/K+Ax8kLV0VDmZ5JMKo5nvK0P/grnFCZlh6KMWoMlre4j4odSe4/PU5Un3Qg3zw3k6mJ3Ef
 rbnXunIUhnqA6p2zP8tWuWg660cYNtxzUFsCuVqoJvR6qT2NBRQAh2OlF6umdwHlDnNWK0V8h
 wu5NBqS/0o2jPX3joDMb3UpWJi4nAlb2TA6rX+E1IPxTw0+/uE3GoJbM2sLazQuJTMid7t9Gg
 nSA/0V2BaJnKGmIpWPnmRozAOq2VQ0qnO4Nv4AZecVdBfVzFFvpi2X+gSte3qe9uLPxMQ2brc
 heouzYymqxyZ00ipEX3x5qAwxBqt+zd0r2JwhbgBww/acgAUrPq0CfsIKiKFJQ6NPYEnfdToA
 /2h4dsmC01+BV7JBs7MvrAMPQSi+BWBm1y3BBH73TjcdQDGA+GSh0Mt5aX5nZVLIwx4455GtD
 LCA3hB5JoGbxzIaKx7AfeUxW63U4ZtBS0MpEHol7pGE8ApR8wT8asT4AzrDcGtB43fgBIkg9H
 iq6M7ZBcM4vJ2LM4+MkachVA4X5aEK4aOaGkw3aLua8FRzLAXtEPAMuAFTk4ZzGjQBvFSAvGj
 EUNcqmtcbl7DYfUPDR0LsdyN9haq69FxH9PSF8JFjeKetVt1DksKLKOlFP+QSHeRZuir1L2bs
 Fw6j3XJWi2kffaR7DmcAjZP8blYRY4cqKMIr1uNUi7f+KHi5flx3s4kEhOc2f0hbBAJjLQEvK
 bfebwm2gNj5VuBwAQ2s7QUTEQwZpHdZDBuPQnQCi883q6Ol5M6QyOUOCF5KHyX8/Aw9n8fjKx
 zpS5MEiyGJT/cXnwXXX5aKgf6O4jr8XJt1hBq8QfPy96I9iL91aKMCuGDjsx6qYaYhbjywSGZ
 QslCJ7y3pWcnBqCj2pQJAdKherafUKd2r6VBCMRXd5W8oFQnh2bgRNZwrxbJwyrgbeqk6j2QU
 8ykjPKQ8

Hi Sander,

On 05.11.26 22:51, Sander Vanheule wrote:
> ...
>> =C2=A0
>> +static int rtpse_mcu_get_global_budget_idx(struct rtpse_mcu_ctrl *pse,=
 u8
>> *budget_idx)
>> +{
>> +	struct rtpse_mcu_msg req, resp;
>> +	const struct rtpse_mcu_opcode *opc;
>> +	int ret;
>> +
>> +	opc =3D &pse->dialect->opcode[RTPSE_MCU_CMD_GET_POWER_STATUS];
>> +	if (!opc->valid)
>> +		return -EOPNOTSUPP;
>> +
>> +	rtpse_mcu_msg_init(&req, opc->op);
>> +	ret =3D rtpse_mcu_do_xfer(pse, &req, &resp);
>> +	if (ret)
>> +		return ret;
>> +
>> +	if (resp.payload[4] > 0x7)
>> +		return -ERANGE;
>> +
>> +	*budget_idx =3D resp.payload[4];
>> +	return 0;
>> +}
>> +
>> +static int rtpse_mcu_set_global_budget(struct rtpse_mcu_ctrl *pse, u8
>> budget_idx,
>> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u16 budget_raw)
>> +{
>> +	const struct rtpse_mcu_opcode *opc;
>> +	struct rtpse_mcu_msg req, resp;
>> +	int ret;
>> +
>> +	opc =3D &pse->dialect->opcode[RTPSE_MCU_CMD_SET_GLOBAL_BUDGET];
>> +	if (!opc->valid)
>> +		return -EOPNOTSUPP;
>> +
>> +	rtpse_mcu_msg_init(&req, opc->op);
>> +	req.payload[0] =3D budget_idx;
>> +	put_unaligned_be16(budget_raw, &req.payload[1]);
>> +	put_unaligned_be16(0, &req.payload[3]);
> You don't want to configure a guard band? Can this lead to flapping of d=
evices,
> where a port is rapidly switched off and on by the consumed power going =
above
> and below the power limit?

Maybe I got the idea of that guard band wrong, haven't found a good
explanation of that setting either. I just wanted to avoid setting any
guessed value here which reduces the global budget from e.g. 400W to
380W without specific reason.

>> +
>> +	ret =3D rtpse_mcu_do_xfer(pse, &req, &resp);
>> +	if (ret)
>> +		return ret;
>> +	if (resp.payload[0] !=3D budget_idx || resp.payload[1] !=3D 0)
>> +		return -EIO;
>> +
>> +	return 0;
>> +}
>> +
>> +static int rtpse_mcu_apply_global_budget(struct rtpse_mcu_ctrl *pse,
>> +					 struct regulator *vmain)
>> +{
>> +	int budget, ret;
>> +	u16 budget_raw;
>> +	u8 budget_idx;
>> +
>> +	budget =3D regulator_get_unclaimed_power_budget(vmain);
>> +	if (budget =3D=3D INT_MAX)
>> +		return -ENODATA;
>> +	if (budget < 0 || budget > U16_MAX * RTPSE_MCU_GLOBAL_BUDGET_LSB_MW)
>> +		return -ERANGE;
>> +
>> +	budget =3D rounddown(budget, RTPSE_MCU_GLOBAL_BUDGET_LSB_MW);
>> +	if (!budget)
>> +		return -ERANGE;
>> +	budget_raw =3D budget / RTPSE_MCU_GLOBAL_BUDGET_LSB_MW;
>> +
>> +	ret =3D regulator_request_power_budget(vmain, budget);
>> +	if (ret)
>> +		return ret;
>> +	pse->requested_budget_mW =3D budget;
>> +
>> +	ret =3D rtpse_mcu_get_global_budget_idx(pse, &budget_idx);
>> +	if (ret)
>> +		return ret;
>> +
>> +	/* Retain the programmed MCU limit even if later probe steps fail. */
>> +	return rtpse_mcu_set_global_budget(pse, budget_idx, budget_raw);
> This index is different from an earlier version of this patch, no?=C2=A0
>
> My (old) documentation [1] describes the retrieved index as:
>     "Last updated PSE device ID. Also the PSE device the budget belongs =
to."
>
> I'm afraid I don't remember what I meant with the second part, but I sus=
pect the
> power budget needs to be configured on all PSE devices. Does this work
> consistently on switches with multiple PSE chips? If "last updated" mean=
s it
> might sometimes return a lower index, I'm worried this might also lead t=
o some
> cases where you query the MCU in the middle of an update cycle.

It works on several devices though I haven't pushed done tests to push tho=
se
devices to a specific global limit. I should probably do that soon to have=
 more
of an idea about this behavior.

On Gen2, this doesn't refer to PSE indices but to a bank ID, and the whole=
 system
apparently only uses one bank. It seems the bank is not changeable too, an=
d
vendor firmware I've seen also just sets the power on a single bank.

For Gen1, the assumptions are based on that part "the PSE device the budge=
t
belongs to" and on the userspace reference implementation [2] (grep for
pse_id_set_budget_mask). It varies for different devices there but most se=
em to
work also with a single index used? Also setting this budget on multiple
downstream managers sounds to me like we would grant each manager this
budget, unless there is some weird inter-manager communication going on.

Users in the OpenWrt forum came up with that issue and ran some own analys=
is
on vendor firmware. At least on the devices tested there also the vendor
justs sets the budget on a single index [3]. If some specific devices real=
ly need
this on multiple indices (like GS1900-24HPv1 in realtek-poe?) then I guess=
 the
switch-specific compatibles need to be used for that purpose and a slightl=
y
adjusted implementation.

> Otherwise this looks okay to me. I'll try to test it over the weekend.
>
> Best,
> Sander
>
> [1] https://svanheule.net/switches/software/broadcom_poe_control_protoco=
l#get_power_statistics

Best,
Jonas

[2] https://github.com/Hurricos/realtek-poe/blob/realtek-poe/src/main.c
[3] https://forum.openwrt.org/t/support-for-zyxel-gs1920-series-gs1920-24h=
p/155683/170
