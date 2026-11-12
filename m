Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=67.231.153.30
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794444717;
	b=cLiui36eVz7MhYg5+Cmzo3Hlnlc7olzcDpzoLidb6OVp1lmt2XHxFP116sTgJa+uNrY7
	 hkoh/iP9K2V9iEIp5H10B1IUEEkyh3m5ajvx6CL3P8LQUKwHP/eynCAPBsm7ITklaXooX
	 kNhsawNw4/qeZoPRPfhOZwwfzVyAUOeALttwC/OFVWNCy7zr2/Z9kjBpffnVqIkRZ9tb7
	 9J1c+WajvT0hDUtz8wVenKUhhdXP4QYhJhkAsVM6ME1++TCM+AA4eFnMboMH4jkMcCXuJ
	 jh6jH4nAIVd2cIOAsTFiNcEgbO6vkTVFGsBocLppl7j4Juz2THgOj8wx8uV4bCxSElA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794444717;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version;
	bh=COvz1LYfsfnPEz5Rqox0HEgHvMOUnAt/U2EOg+WNlZU=;
	b=UEYfFF3mygCtxVWrwMW2wtddy/HA4yG2GYNC5F6TNHlFaOLM91wgVOfCd3+6SW2wgnUs
	 IkHLu17z56RnIl7bHm5yYnVd7L5FzoR6ZBnFbcy8stgEzeW5zWsPnCCKHzElvIAyUawXq
	 J1e7bhse9ArpT6d0U5AiF6CQccgY1NjyuOnkaS87urKY7gBg48MqLa2JD8bnFXqMQhlbo
	 NPYA2hb/KLDg/TgvKQV8JCRWkVa9au0OOcr5SFDPc0aMtzNR13hs9IkjGIMMdGGOthexm
	 QHL8hY2XoadsoI+UAe13pRVX2ZNxsrr9FDXKMWj4qGkvS5cZFhgjExWcWPEJAiChz7w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=meta.com;
	spf=pass smtp.mailfrom=meta.com;
	dkim=pass header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b="M9reJI/S";
	arc=pass header.oldest-pass=0 smtp.remote-ip=67.231.153.30
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C424606A32D
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 00:51:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5C424606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=M9reJI/S
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 6AC02jqv3923252
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 16:51:56 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pps82601-s2048-2026-q3; bh=COvz1LYfsfn
	PEz5Rqox0HEgHvMOUnAt/U2EOg+WNlZU=; b=M9reJI/SbRv3KTUBSw1H39UYEB+
	5lytBhF7hV4YQaPVXjAXypBnalL48KDk1A1rPKkW4JS7QlVjoHRcEgxDsnA3DkFA
	V060Ck2jnCyXydM8YqDn8C+78ia42U3pbptfzsZlVy9Q4snVD20ijYvY83yoTAm8
	ocCd0aFLyIXSlQmjSjI4EMdJy/wmj2AUKlRJZxWjN0PrKyVpD34ID8GoMpx8amwx
	sUFDPaIZYs7/+VMoJ2ms1f1pJNJM2ePMvINLR5wuKhj4NwbcNnaqKiw3F04xD0Hl
	fQXX3j31JGidEqXUi2+1MYP8OtMbJoF6w9Rm0iCvm3rpqRXC98O03u3+rog==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by m0089730.ppops.net (PPS) with ESMTPS id 4huqmrhcan-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 16:51:56 -0800 (PST)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3b19aa066afso208132a91.1
        for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 16:51:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794444715; cv=none;
        d=google.com; s=arc-20260327;
        b=ZsgRuZw897t/WBr7Vcv+aK7yaxmo84O4V+qK/6LLJNVafIvmT6r6SrCnyWXDv+p6JE
         NbhzmjwYTKnBdY/9jgsPSwKjrJmQRChRHpmQhy3M3xEHqKhOTXbN4lSx21OC/RZIvSeR
         1iybTiBoK1ShkMP8OuMoBfe7K3GtdQN6Nyj8kNuFVaT9Bejo4/gtD953ppCxv1cQjYpa
         9ooi3yMnt+0Q5v8cyXl/ORSYq2zl2O/26V8lhikIupehqxMSSXDJ006ExyuImr0yGuWu
         9gBh7SepOStTmlDEtEhWMgqiAozBDGxQYJqbSlM2R04yDXojdTrD3THrni+/Ga6Ng8+m
         jg2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version;
        bh=COvz1LYfsfnPEz5Rqox0HEgHvMOUnAt/U2EOg+WNlZU=;
        fh=Pmj0flJu1UnzQXPteF+BeXRUrdGICr8j0xYNarx7zbU=;
        b=AfAl9xgzYonVahxsn3SqfwL4ZO1R3OgFOqk/JSp3WycX4eYkvGSSaVVDhZxxBg+CTd
         TV1annsDoEHLLxIBo4cB90T613b6dvIe+lnFQYng8u7PU+DpmclUtHm7puvLPH/s7FxT
         Gjw9RxrDe7ZrriznpsMLXLsPnfw9RuFzJrQBiLMrpFpmJe2AR/BUNZgCAy4iCblHU5yb
         ZPEsQrDVlssKFJnH0hRf8T6cM6X7oz4ocR+yOKlzOiccBoUc5uujM4N7TiZDrjkCUYz+
         HpCh8GpmCkY5sVk547KMQVRCbSxa6b24I5jm1+KpuzshLoBH1sxBw2JFPHKU3Vi3oQgz
         Okqg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794444715; x=1795049515;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=COvz1LYfsfnPEz5Rqox0HEgHvMOUnAt/U2EOg+WNlZU=;
        b=xq/xniU8v4PVg59D+1+9Q40TNpqN1/1bdNaxGZD+NP7SQxzyif7w3TcvvgC2WbH0Z1
         F2zjXDl1RY3/2l7JdAi6e0JeTLuWA65MCIEPynGJKG1qL14I/7ZNc72wqZsLgJbD5QLZ
         91MJUz+SG2nkWQJwqW+NWB5XqjQqo8cfql+KALNC6VrcXCK0+ql7oNqQ7vx4K+YRJ4nn
         MGpXGIsc/NIoFFd1SGk/wu8c3BxFl7RArg1+zRRafmHTYC5zj3b2T2Jo/zmShMGynyH1
         cick5+oco3VNAiVcWiFA84ajskKMuI6Zg5obngdbFw4yNdRCk16FIBnulz4krGxMk2Ki
         go/g==
X-Gm-Message-State: APuU4Z+YIHojLCN2wL8P9+joycBgXny8QsrBCJVgdWSqgR0zvzCoHQpK
	srHTSndreIUEQFh6Tu2g1vlmvX/HuMBCmwoC2Z105t+YA7X50NHktXoZjy+h0XMfPg1ESwT2IK5
	W1DM8nN+0kJQu3Q8sqGY8+zTlcRERfLiDNCFY9+6yeT6ou1Iky1pMc4GfSpEf8s2pxtpK2LYKua
	PxSwIgK9tPX3MRu4bnX9/K3Xzbv7RgSEw=
X-Gm-Gg: AYBFou2J/r851yyEQ94Bt90hF71kk+HeY/lXi5IGcYziixSf8DBZFnpisYD+ZHl6t02
	taK9GpyRbcGmeL0sgi+AZiMCXQnN9sg67o8diVvjbFgUBglb8KdJhWgNZSH6LLINZHe8DQ+XPjp
	SfFAvajEMk45R94+gfnbQIrfpFb4CUw2At35ccO8YY07UNa3fsYjb2oa7NgPhZ+AjYFb9XUklyO
	wMwP21PNFsr7CvhdB2n8e4hpjOQAUwZ
X-Received: by 2002:a17:90a:8c8e:b0:3ab:d26b:c2df with SMTP id 98e67ed59e1d1-3b197cadcdamr475957a91.27.1794444715025;
        Wed, 11 Nov 2026 16:51:55 -0800 (PST)
X-Received: by 2002:a17:90a:8c8e:b0:3ab:d26b:c2df with SMTP id
 98e67ed59e1d1-3b197cadcdamr475937a91.27.1794444714456; Wed, 11 Nov 2026
 16:51:54 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261111005533.6436-1-toddfreed@meta.com> <20261111005533.6436-5-toddfreed@meta.com>
 <DMSJB8MZZCXK.MCEBRZQDAM5Q@gmail.com>
In-Reply-To: <DMSJB8MZZCXK.MCEBRZQDAM5Q@gmail.com>
From: Todd Bert Freed <toddfreed@meta.com>
Date: Wed, 11 Nov 2026 16:51:43 -0800
X-Gm-Features: AclHuK_TCwMOAV1WvAw9HnkDUPDvVUUNIB0-FrcHVRqyh165RWlzsz9oCiRdiUI
Message-ID: <CADh2yMzdD3FSJSAY2+vJYADwRg704Ndqwz2DhAC3nhmyZe85jQ@mail.gmail.com>
Subject: Re: [PATCH net-next v1 04/15] psp: add support for socket-less psp associations
To: Daniel Zahka <daniel.zahka@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
        bpf@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
        Donald Hunter <donald.hunter@gmail.com>,
        Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>,
        John Fastabend <john.fastabend@gmail.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-rdma@vger.kernel.org, Martin KaFai Lau <martin.lau@linux.dev>,
        Paolo Abeni <pabeni@redhat.com>, Saeed Mahameed <saeedm@nvidia.com>,
        Simon Horman <horms@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
        Wei Wang <weiwan@google.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDAwMyBTYWx0ZWRfX9Z0bn/LKqAnx
 ZfTUXJvGhBNizy/D7GtUhlZIq0ufA/d2OWhnAiywD5sFOSTP42QO833gwdIPEHS1wk+BVhxtFNE
 PhVuNPR1LBV7b0+DrvYSo5n8C8D3++I=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDAwMyBTYWx0ZWRfX4m7/OEWTfVYs
 ivMtmT7ONPqn2wAdleBCpGtnatFHZ+5UIO5bO4TAk4sAYBL4VxtWkKsK9fYP1WfWdFI/z1qAFye
 rC0oXJlPqUb8JP66JKNZq9hxmCX0cQCxRbVi5Qdi/yWn1MdCWVlx/gCDlkVRGPzKnH4k8tMusBN
 9dgukV6u4MIiljh3wlJurIKQCxc/98uvsDmxdYM3EZkyY1K2xnQGW1zFrF0yGrpUXgPwmI6HEYm
 hnwaTdQ3iKGTd/Vvn+itYB9MyQ3cBOpNEW4R+ZoHjWBctH5lScklbpSONUcRpdZmab5wZS7EszS
 2Eb3wwKENAbWJ0wceK+8Yn+a+YYDcQL5HygjNsa/FCkTKjv+t1f4YURinO6cbxzJYb7bQaLYp4K
 +mlGlHOOeerOu147ZHTbnVoeG5k8h6zBRX3rr0HKV2HwVZNqMaWwnLHX7GD6LVnUI/UwfTI4Vn8
 fM0IeG9GMYwH14TRVhQ==
X-Authority-Analysis: v=2.4 cv=YIgKWhGx c=1 sm=1 tr=0 ts=6af50dac cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=855S8uPTkML1Oy45N9_h:22
 a=EaETVqjJsHDKXBk3jaYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 2FtvPJTeoi43Q28rcFMvOySBVWRIBeUA
X-Proofpoint-ORIG-GUID: 2FtvPJTeoi43Q28rcFMvOySBVWRIBeUA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_06,2026-11-11_03,2025-10-01_01

> I think the design could be improved by not reusing struct psp_assoc for
> the socketless rx spi accounting, and by not placing the socketless tx
> assoc on the active, prev, and stale lists next to the socket
> associations. I'll try to comment inline to give you a better idea of
> what I'm talking about.

Sounds good, I will do this.

> I would create a separate list for the socketless tx assocs, so that
> SADB handles can be flushed on psp_dev_unregister(). Then you can just
> leave this function untouched, because invalidating the generation is
> only for __psp_sk_rx_policy_check(), which isn't used by the socketless
> rx assocs.

This sounds good as well.

-Todd
