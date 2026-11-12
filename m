Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794452456;
	b=dDmqk0rXufLc6Ku6eYd8yPIV0z8+5v5W1r3QTYupWQy4zBCL8cIyJeFoRHit7Y9bFMxw
	 rEeKTC2EoYPILYbou87CyKqw7kjX1g0sdLQyGwcd36EUfdDEFtj8qkOQ9QYa6hA6//Hxx
	 tqJ/bEwMtMwUAgCj0OTCsR2EqST5XNstvg8e+0QXDpGG0kZl6OomewnwduS8RqZdw3I3x
	 3U1CRyofOYnndHPwJGEq21hrZNJis9DsFl9BHFz1xvkEW/d3lKeAv+vtJ7a7N+ViXSeQw
	 Geo+vJS0sua7nCmsekGT2sAnkdMuuysz/REcK5Z3b9jjR705KlgRUX6099PPy5KFYDQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794452456;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=0ker/e6EtIU4OfORlKixSoRdHPkrYE+Fp5n7xeEspxk=;
	b=c6i8g1hJGvXDmzfxi7HCdrKIQKcAKhKhr8i4pw4JAMFqacAUwVIKJbk5dkYaVCq0HlrW
	 pHMJ6On7ixRvUpVSDT+T+4+XpYpatQYmgQ0unVYAX4wW69MavhFx1QAMdNWSMHAGo9ExD
	 1HHFexzPC7N34AfaicSUTFr+5wUv2D9WRxpH5wV+ZLgCNat7nVEaojkJnYOYVKFV00Kks
	 3FvsCJ2DWM3fY40k1X94j/Jh6qsFnhcc2k5INxLsIps6SQqTefTnAE0wYMG8dVjiB1H1l
	 lR+w2L1lq3IvnZ/QJhOa69dWqap81Uac/HLXKcMoo8lWD6jjPSBG0jzmsefbyIRQ/ig==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=FTTco9lA;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=L5+nTpdZ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF24606A324
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 03:00:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3EF24606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=FTTco9lA;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=L5+nTpdZ
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AC2ZY6d3158667
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 03:00:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0ker/e6EtIU4OfORlKixSoRdHPkrYE+Fp5n7xeEspxk=; b=FTTco9lAaClg0qy7
	paSGkH1RUK1r3PkEpXNRMMzJeVviZF/6qNKW2F2qfKB3yacXPk72rJW4gouDYDyh
	zo3yATC+E4zrHCfngpeztPAlrGCQaB+l+kuvO+YbpH9u+AbMohSQ9KAZq6SyPVzy
	KaEssSZKwFtvvPaSs9nWknAZ6lL2ZGjeYNWIhQKrvCiGwoNltoZuwub3jsx3cVeQ
	PUIsgh8ug3j7giWLMWbErIaBqCa8EPqDy7uZOgiuIRHwrbyDxy1Py2WhJQr7k/5y
	+qKlylc0NyL6AruGDg5Xkq7aNT3Okx55QTV7JD6wuPdmdJEiVetlRvEWGD1IlVjm
	7brqFQ==
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com [74.125.224.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hvk7pv7u5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 03:00:55 +0000 (GMT)
Received: by mail-yx1-f71.google.com with SMTP id 956f58d0204a3-67c041acd09so5660464d50.3
        for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 19:00:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794452454; cv=none;
        d=google.com; s=arc-20260327;
        b=KX27goibCVcK3QJQjkwDSAvmSjYbYAKt9oqjjr8S79odR5JbGHPc0Ff0aKNCN5b8eZ
         jn5rAcU3IhRh6Q1HHzXCZgkocVxDTPvxEEh/uPsdxRMMI+3X8ipy0ibrc04bqOvnLAcg
         9ssEgSXaUjCq8IsD3adS122oj3CkThwmXQn2jGvubNYSr2MKkIMFeCtqcOQpeGRfkR8E
         Yk6NgY+6yY6Fgt2q7GLVHYbOary3f8DSdqID5IhlFm2eEe2+eDX3vb42+3utYN2DWGqO
         9AIAN8OvZVrvuJA6ocwR2+r4JbwtYfZrX+QMaqyLu096MBcj//KJEEg8YlLeFXfB1LxL
         jqKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0ker/e6EtIU4OfORlKixSoRdHPkrYE+Fp5n7xeEspxk=;
        fh=IuMHDrivrb+yz/28nIPuB8qNBKQs5muYNQsLhHQ8I1c=;
        b=IcVjoozfBT0hoFV3upiAeIuqGq6nRnNNItxHUDtrjXrQzKYfr9sYObrdERRDcka5Nf
         IV6Ba8IOlnh5DzwTlyCVzktE65eVs9GsZR2nMwmncXDgn12kkqBEOTFpAHMszEZiOqLP
         TXQQb7DeX+aIBbgZxNcLlxojKgytKW7TfqZMi53lJOXZ/LFd9if6xn/uxoIg6rJqZA+h
         cZm8OXr1yEeWFK+xvSxu/R0mAY9FmPEDtI7peTy6mXkr7CBEN2OR5NAlJKWYgsUsmPnZ
         11XF8GLN5PalRc636pZ0esYa3HMyg4VPb88GkP1mstiIGUl4/bE+eRLw0pom8jZ9uJiz
         GxHw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794452454; x=1795057254; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0ker/e6EtIU4OfORlKixSoRdHPkrYE+Fp5n7xeEspxk=;
        b=L5+nTpdZUtV13iR13f3WGMjWXpxh1XMcHTcanhn8zUlges3A2XoQ7frC0IGKh3YNGC
         UP4ToBZ575+b4SXgmJv/W8ujg5QZMKQZCN4ODHey2/3P+Er9U8M4J2gnoKLBbjLb/zcz
         oq0Jsw8APTD4Xt/kIdVsXKh5EOYdPhWQL/x4trlYzqKKztYLRtMDhAxMPa36iVK8oHIE
         9+IsysVixaFR3TLBxPxQZwzKXuC+BXvbnDtI7oTjMqaXyhVCNyy67ta2ihw0BVcPm8Iu
         g1aHVcnPIt6Ja2WQPMfHFGATfw9kaIuviCGUsM1DoXJ33vhEAgW02crjHynzMLPkseDc
         INkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794452454; x=1795057254;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0ker/e6EtIU4OfORlKixSoRdHPkrYE+Fp5n7xeEspxk=;
        b=iGBil9KmzIx9vRN2V0d4FQponCAll2pZ67nn6Wsk6UI70v/YnSonUOrLw766W4qvr2
         72J8XHEnuENNCu5FYa/LpP8dHwoh1pQF4tnMJnXtDYfEoCKUxcdoWRy1ddeNxQ+LSwRC
         QD8/bTyd/CbAaRk794/OfkYOYLWQk3qK6h9fNbwGtXSWynp7XeZ+nRQN6/Ab7x7d+Osg
         nvt7YEzxdcc2+2ENTu2SzidPtOpYdE2g/V9yFXzv9RwJxaIgc4APAp2YjkRJUbtUEPaq
         sXlwl1MG0WWN5evpgOalRCe8nzu8I0hWopwqivOZ3azo//1fUDXegHxg4K/xLwGOe9Eh
         3kmQ==
X-Forwarded-Encrypted: i=1; AL+hErGN3b+3SAMyOhDC+zd5OP2KlXWZDjvWUmZdBkg8L81OL6MQ/YxjXu/uFCzoYtPueml3jUI1WhY=@vger.kernel.org
X-Gm-Message-State: APuU4Z80SCFDY+Vj6yzS9hhayIFIVbUkOCv7dECVOz4qAC+SZorPXOK2
	XzNy54pICTzKLXU9rSh5O2Gd8BfuPMX1vPsUqdwHe9ALdIdZfK7QKgY4rvLrhGGJwpw2VIVxfkB
	WyzM19+4VoqnZ5R6cOWJEAgtP4zqYJfrIWkC7ahnRks19JCwd76eXdXL6iRCn10AN97HG4Tjzzw
	zU+ol74YFf5zmiwt6Zt8FtBF3JKrkLXrcqSA==
X-Gm-Gg: AYBFou3DVV3qnSMdZc+1nYMXxFHdtk7IlZeW9vo0/fqxFSAzcHI9fx3BD7c4rof8atX
	PQNasDY+kRqUlkSK0xhcQW0wXiEkwtnm3Fpf43UMY/vCW+goHpWrrtn4TDuSi2OZc7CVkOqqGCu
	59DZ5hKLah+dcfAcjKzDkrV+tUDF9nupkouqRR1UMYB++gKD1/9iEjkIqUcw==
X-Received: by 2002:a05:690e:47da:20b0:67b:fd6a:bc1a with SMTP id 956f58d0204a3-67c681084a5mr1880271d50.163.1794452454410;
        Wed, 11 Nov 2026 19:00:54 -0800 (PST)
X-Received: by 2002:a05:690e:47da:20b0:67b:fd6a:bc1a with SMTP id
 956f58d0204a3-67c681084a5mr1880255d50.163.1794452453847; Wed, 11 Nov 2026
 19:00:53 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261111-aquantia-poll-global-status-register-v2-1-b602fc7e80a9@oss.qualcomm.com>
 <20881de9-927c-41c1-ae30-829382d531be@lunn.ch>
In-Reply-To: <20881de9-927c-41c1-ae30-829382d531be@lunn.ch>
From: Hongmei Xu <hongmei.xu@oss.qualcomm.com>
Date: Thu, 12 Nov 2026 11:00:42 +0800
X-Gm-Features: AclHuK80fTtqa5nlpttp9lfXoNbkIHr6rTn_KulU4jNliXlNEOaMYSAQUCN8MQg
Message-ID: <CAPTcHHTJGdCq4zXMhv5iuGVrgeKJgN_5MdG4Joh++biR_J15Tw@mail.gmail.com>
Subject: Re: [PATCH net-next v2] net: phy: aquantia: Poll global status
 register for provision ID
To: Andrew Lunn <andrew@lunn.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sagar Cheluvegowda <sagar.cheluvegowda@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDAxMSBTYWx0ZWRfX/PkTLqxTwuiw
 sHNc3hwitDAOPlQfXsRI67FjXwxLUbUK2+qN85CzMpl5NDvDMxGGJExbMZ5m3kUDjNuklfK0gn+
 LrV3XJQ79+XaEiHYJW60poDyNDdD/9U=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDAxMSBTYWx0ZWRfX/nJg4KQHAn1J
 vazhLu8ORxBOVbm7208kipWG1n6wtvBv/6WLuxvp6x2PziA6n6D3xZ9s+1KMx93dZTdq4JES+pR
 D/j5lt4rvbdI9nm3Cpj+8Abmuy5RfbVmoPqzwgHy4GiXlI979QoeUiP1I58JxsiXEinVvm7A7YS
 Sl/NkvsPnHE1d0giZfduZ214YcAx9btkYh2GS+8t/VYotIt/BP5FGHGkQ5Sct/3lxQ1+kNDdWsp
 k+HuBpWbIAmphld/F3VK3iLxXlmuBgY6ptL4A9CLiS/l0a0poPIevU5OFiNTUzDWnoX0L6HBSjy
 PnWgde3Bq32ekUnaXW3Yu+unXVTxNHT/rgJwRvqajMF6P/pQ53Zif7TvQUnq4dW19vCrEywIPAV
 y9VfagThlJxz/TI0mZmUFHq/csODGQy/Li5qwNrAi3gWHDx4LaWY992MCQqT8iMTsGmWkV3bfok
 o24kCKLyCIldbtGB2uw==
X-Proofpoint-GUID: QZKSTbuaTem-dwcV2hL_KUZJ4euSQg2A
X-Proofpoint-ORIG-GUID: QZKSTbuaTem-dwcV2hL_KUZJ4euSQg2A
X-Authority-Analysis: v=2.4 cv=BpcIUoX5 c=1 sm=1 tr=0 ts=6af52be7 cx=c_pps
 a=ngMg22mHWrP7m7pwYf9JkA==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=YMgV9FUhrdKAYTUUvYB2:22 a=DX8JRrE0vvtK63t69ZYA:9 a=QEXdDO2ut3YA:10
 a=yHXA93iunegOHmWoMUFd:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_01,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 spamscore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 phishscore=0 malwarescore=0 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611120011

On Wed, Nov 11, 2026 at 9:40=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> > +     else if (ret)
> > +             phydev_warn(phydev, "Firmware provisioning ID not ready; =
"
> > +                         "interface mode detection may be incorrect\n"=
);
>
> Please don't split strings. Somebody is going to grep for "Firmware
> provisioning ID not ready; interface mode detection may be incorrect"
> when they see it in their logs and not be able to find it.
>
> This is one exception we make to the 80 character rule.
Sure, make sense, will merge the log into one single line.

Regards,
Hongmei Xu
