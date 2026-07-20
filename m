Received: from mail-yw1-f227.google.com (mail-yw1-f227.google.com [209.85.128.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA6243D503
	for <netdev@vger.kernel.org>; Mon, 20 Jul 2026 16:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784566673; cv=none; b=lJsL0Cuz2deG3CPtNzWYWCYiGE2t8glywKPEdDII7KV043WDJbAyda9FqwDDZSUgmzcIAVvztjuoV0xRkqKzd+ANii8hobDNxJFeMn7UXOCUWQ1QitIAUeDl+MooPYPbv1Gtei8qwsVDtSERIQ8KLVV+jac59barg590GNBR/5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784566673; c=relaxed/simple;
	bh=Kl96iNUE6N161Bq/O0HW1K4UZ039Pj8e7/Hw5uQeP7g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PpwFoZ/WrCNIqNAHCzVjnuQZ7yAxKO3ZQI6Mj/3pK0bKghsgavd5MNxUUWWQA8HvWuVt8Ew37QIPKy2IHb+1yOMmZrarvmwqxTcJ8GJdDh4z4pEZTooEZ5QCwTDhITAogiK7JmIANRossAap5wYJaw5s0XiUUbrTzVExTm7DA9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=A0NlM4lf; arc=none smtp.client-ip=209.85.128.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="A0NlM4lf"
Received: by mail-yw1-f227.google.com with SMTP id 00721157ae682-81ed2a06b9eso48791817b3.3
        for <netdev@vger.kernel.org>; Mon, 20 Jul 2026 09:57:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784566671; x=1785171471;
        h=content-type:in-reply-to:autocrypt:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cRh4J9XYgO70VYnqwrJbk9PRwGo3+G0lKOvm7C5IMw0=;
        b=Ki+gy+d2QIAgMPlLwV6qkepiiaX4eOuj7dhZb0Dx/AjVTEAX2Ww/wWviI0ULQZnNU+
         rXwyljqSRiVBtsZMOSME1w4CpUFxwoJNciLFDyVxhsjjkRWOcG5JWQnGYdfdc4mniNDs
         X3reUE0rV8xylCGqOa0GBpxugPQmoyJOjXyQ/f3FYBdfS2Zh6/srhkzaKzpmmdlCMVCd
         klxBvBtBhX+6r6CXziL5p57TxnjcmYUvjGa+j9tog4g288g6HjC5fvmjTUiAYBUSlJ8l
         Igr3CzpyTGFlfYsd4K72rJFrrRufd0ye9rE0Qrhs3OCeV6Nr+aSLNAGxYhS2jZylWD7j
         hB5g==
X-Forwarded-Encrypted: i=1; AHgh+Rq2h0AGYW38p0+jzT1/8cflJ6ER6dP+0hUw9mD1wo7gtep7YWt/RkoIFTwjIJwYY9xNJ8tTEVM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5yvspgWh0+omVeLlxWlTB9tkZRAyGjsWd606T+vyrcC1116Wv
	g1V2gcjF269kBeHiM5+6HnaC5v06Olhscfjfidz1BQnxiSDWG62u/Lxw0ZHqaIc9nBIr0GWs4au
	1gd/P1rdx44esg+bX0VfzSJFlAx1nIglbs5BeSsLTf47FazGRJdPWUzyROjOdJrHNJ3a1Zv+ogU
	VcDeqktWHF7WEie+ApMRfuXx7DHjqtrUiSUGZjO/3gGe9AYSIOse76eBkx/Dzo2AqdYZwTmSGbv
	VjfPpxIOY4Z+wYo
X-Gm-Gg: AR+sD10wHIXoye73iZjhq8LvFPV7mcwxfxbwVB5rjKLYONG1v5Z5qaMFCnk9d2DKn/d
	hvurb8RvVBtdI61DQF0zPTnlWV3dIuEyHaY+Gd2G8Vdz4g2iOIrQES3ajtWJVXLLd+nLb5BlvQU
	sySSbm1/aGJHxbMNpZZ3xk+MFGzFEy0El4JK3ZvUw/gCaq9FrBxmGCXeeL5bP7H4ESlvjOO0UT0
	1WYQArAyJhjbRZPNbMdCDoTIdNLCS3FoiYBvhk0iahKOH+Jn69jQ4Pe41mVh47jzrgDZRhwcd10
	3YN5jahdRrNsBSdODEHi0yMwaaIlc4ZG/19rAx3SWQjI0vznaM91YKHyLHERff0CvpuzvKK/rOz
	4ej3pLrO8skzWGTReV/7OWZD4c6eL5mqWUHc4L3m/xLCNDkloBnlAySyaecdhawqOOx/w2d6Cq2
	O9irWfZlpBSOhq7svGPuDbG9JSJ6XVWUUSdL9af8cU
X-Received: by 2002:a05:690c:4907:b0:81e:8f3d:1d9a with SMTP id 00721157ae682-81ef25bb71emr43653997b3.39.1784566670776;
        Mon, 20 Jul 2026 09:57:50 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-12.dlp.protect.broadcom.com. [144.49.247.12])
        by smtp-relay.gmail.com with ESMTPS id 00721157ae682-81ef65ccacesm5583417b3.3.2026.07.20.09.57.49
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Jul 2026 09:57:50 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-5aeb55ce6adso3288974e87.0
        for <netdev@vger.kernel.org>; Mon, 20 Jul 2026 09:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1784566668; x=1785171468; darn=vger.kernel.org;
        h=content-type:in-reply-to:autocrypt:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cRh4J9XYgO70VYnqwrJbk9PRwGo3+G0lKOvm7C5IMw0=;
        b=A0NlM4lfoUbKM6h2gTUI5cmzcftno9RocJHqDN7fL3o4+k9JDQYD3N7GnVtAaCz6TU
         2WY3yRGDEIA34c04GSAYEsbp2lZzk9GsKCJJ/4WbZ+a2X45Q8rXKI9wEaCfh6CM2RnHz
         a9J6Me0iZUx2ch9ywwmGpfTGsO9mkwJFp1GIo=
X-Forwarded-Encrypted: i=1; AHgh+Rq+XAoht584z6pa+gxs/TVLSedSaxQceQFTe5fmHC328N0MRbpavtwXb9Q83F6g32RML4cpdVo=@vger.kernel.org
X-Received: by 2002:a05:6512:b93:b0:5aa:8822:c945 with SMTP id 2adb3069b0e04-5b28f9b72bdmr3591631e87.47.1784566668635;
        Mon, 20 Jul 2026 09:57:48 -0700 (PDT)
X-Received: by 2002:a05:6512:b93:b0:5aa:8822:c945 with SMTP id 2adb3069b0e04-5b28f9b72bdmr3591622e87.47.1784566668133;
        Mon, 20 Jul 2026 09:57:48 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b291e1887esm2450178e87.59.2026.07.20.09.57.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jul 2026 09:57:39 -0700 (PDT)
Message-ID: <b8062978-128c-4129-a803-1d02910122c8@broadcom.com>
Date: Mon, 20 Jul 2026 09:57:27 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/8] net: bcmgenet: use platform_device_set_fwnode()
To: Andrew Lunn <andrew@lunn.ch>,
 Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 Andi Shyti <andi.shyti@kernel.org>, "Joerg Roedel (AMD)" <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Doug Berger <opendmb@gmail.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Ulf Hansson <ulfh@kernel.org>,
 Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Lee Jones <lee@kernel.org>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
 Srinivas Kandagatla <srini@kernel.org>, brgl@kernel.org,
 driver-core@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
 iommu@lists.linux.dev, netdev@vger.kernel.org, linux-pm@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 mfd@lists.linux.dev, linux-arm-msm@vger.kernel.org,
 linux-sound@vger.kernel.org
References: <20260720-pdev-set-fwnode-instead-of-of-node-v1-0-2dee93f42c54@oss.qualcomm.com>
 <20260720-pdev-set-fwnode-instead-of-of-node-v1-4-2dee93f42c54@oss.qualcomm.com>
 <ae9da5dd-3528-4270-ada0-d17ed14478e0@lunn.ch>
From: Florian Fainelli <florian.fainelli@broadcom.com>
Autocrypt: addr=florian.fainelli@broadcom.com; keydata=
 xsBNBFPAG8ABCAC3EO02urEwipgbUNJ1r6oI2Vr/+uE389lSEShN2PmL3MVnzhViSAtrYxeT
 M0Txqn1tOWoIc4QUl6Ggqf5KP6FoRkCrgMMTnUAINsINYXK+3OLe7HjP10h2jDRX4Ajs4Ghs
 JrZOBru6rH0YrgAhr6O5gG7NE1jhly+EsOa2MpwOiXO4DE/YKZGuVe6Bh87WqmILs9KvnNrQ
 PcycQnYKTVpqE95d4M824M5cuRB6D1GrYovCsjA9uxo22kPdOoQRAu5gBBn3AdtALFyQj9DQ
 KQuc39/i/Kt6XLZ/RsBc6qLs+p+JnEuPJngTSfWvzGjpx0nkwCMi4yBb+xk7Hki4kEslABEB
 AAHNMEZsb3JpYW4gRmFpbmVsbGkgPGZsb3JpYW4uZmFpbmVsbGlAYnJvYWRjb20uY29tPsLB
 IQQQAQgAywUCZWl41AUJI+Jo+hcKAAG/SMv+fS3xUQWa0NryPuoRGjsA3SAUAAAAAAAWAAFr
 ZXktdXNhZ2UtbWFza0BwZ3AuY29tjDAUgAAAAAAgAAdwcmVmZXJyZWQtZW1haWwtZW5jb2Rp
 bmdAcGdwLmNvbXBncG1pbWUICwkIBwMCAQoFF4AAAAAZGGxkYXA6Ly9rZXlzLmJyb2FkY29t
 Lm5ldAUbAwAAAAMWAgEFHgEAAAAEFQgJChYhBNXZKpfnkVze1+R8aIExtcQpvGagAAoJEIEx
 tcQpvGagWPEH/2l0DNr9QkTwJUxOoP9wgHfmVhqc0ZlDsBFv91I3BbhGKI5UATbipKNqG13Z
 TsBrJHcrnCqnTRS+8n9/myOF0ng2A4YT0EJnayzHugXm+hrkO5O9UEPJ8a+0553VqyoFhHqA
 zjxj8fUu1px5cbb4R9G4UAySqyeLLeqnYLCKb4+GklGSBGsLMYvLmIDNYlkhMdnnzsSUAS61
 WJYW6jjnzMwuKJ0ZHv7xZvSHyhIsFRiYiEs44kiYjbUUMcXor/uLEuTIazGrE3MahuGdjpT2
 IOjoMiTsbMc0yfhHp6G/2E769oDXMVxCCbMVpA+LUtVIQEA+8Zr6mX0Yk4nDS7OiBlvOwE0E
 U8AbwQEIAKxr71oqe+0+MYCc7WafWEcpQHFUwvYLcdBoOnmJPxDwDRpvU5LhqSPvk/yJdh9k
 4xUDQu3rm1qIW2I9Puk5n/Jz/lZsqGw8T13DKyu8eMcvaA/irm9lX9El27DPHy/0qsxmxVmU
 pu9y9S+BmaMb2CM9IuyxMWEl9ruWFS2jAWh/R8CrdnL6+zLk60R7XGzmSJqF09vYNlJ6Bdbs
 MWDXkYWWP5Ub1ZJGNJQ4qT7g8IN0qXxzLQsmz6tbgLMEHYBGx80bBF8AkdThd6SLhreCN7Uh
 IR/5NXGqotAZao2xlDpJLuOMQtoH9WVNuuxQQZHVd8if+yp6yRJ5DAmIUt5CCPcAEQEAAcLB
 gQQYAQIBKwUCU8AbwgUbDAAAAMBdIAQZAQgABgUCU8AbwQAKCRCTYAaomC8PVQ0VCACWk3n+
 obFABEp5Rg6Qvspi9kWXcwCcfZV41OIYWhXMoc57ssjCand5noZi8bKg0bxw4qsg+9cNgZ3P
 N/DFWcNKcAT3Z2/4fTnJqdJS//YcEhlr8uGs+ZWFcqAPbteFCM4dGDRruo69IrHfyyQGx16s
 CcFlrN8vD066RKevFepb/ml7eYEdN5SRALyEdQMKeCSf3mectdoECEqdF/MWpfWIYQ1hEfdm
 C2Kztm+h3Nkt9ZQLqc3wsPJZmbD9T0c9Rphfypgw/SfTf2/CHoYVkKqwUIzI59itl5Lze+R5
 wDByhWHx2Ud2R7SudmT9XK1e0x7W7a5z11Q6vrzuED5nQvkhAAoJEIExtcQpvGagugcIAJd5
 EYe6KM6Y6RvI6TvHp+QgbU5dxvjqSiSvam0Ms3QrLidCtantcGT2Wz/2PlbZqkoJxMQc40rb
 fXa4xQSvJYj0GWpadrDJUvUu3LEsunDCxdWrmbmwGRKqZraV2oG7YEddmDqOe0Xm/NxeSobc
 MIlnaE6V0U8f5zNHB7Y46yJjjYT/Ds1TJo3pvwevDWPvv6rdBeV07D9s43frUS6xYd1uFxHC
 7dZYWJjZmyUf5evr1W1gCgwLXG0PEi9n3qmz1lelQ8lSocmvxBKtMbX/OKhAfuP/iIwnTsww
 95A2SaPiQZA51NywV8OFgsN0ITl2PlZ4Tp9hHERDe6nQCsNI/Us=
In-Reply-To: <ae9da5dd-3528-4270-ada0-d17ed14478e0@lunn.ch>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000061125006570dce22"

--00000000000061125006570dce22
Content-Language: en-US, fr-FR
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/20/26 07:38, Andrew Lunn wrote:
> On Mon, Jul 20, 2026 at 11:24:51AM +0200, Bartosz Golaszewski wrote:
>> Prefer the higher-level platform_device_set_fwnode() over the
>> OF-specific platform_device_set_of_node() for dynamically allocated
>> platform devices.
> 
> Why?
> 
> This driver is OF only. It does not support ACPI, and probably never
> will. In general, networking and ACPI don't go together, ACPI is not
> sufficiently advanced.
> 
> What is you use case here?

The driver has been, or was used on ACPI-based platforms:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=99c6b06a37d4cab118c45448fef9d28df62d35d8
-- 
Florian

--00000000000061125006570dce22
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
tJVewHuOmXgWQxNWV7Oiszu1d9xAcqyj65s1PrEIIaHnxEM3eTK+teecLEy8QymZjjDTrCHg4x36
2AczdlQAIiq5TSAucGja5VP8g1zTnfL/RAxEZvLS471GABptArolXY2hMVHdVEYcTduZlu8aHARc
phXveOB5/l3bPqpMVf2aFalv4ab733Aw6cPuQkbtwpMFifp9Y3s/0HGBfADomK4OeDTDJfuvCp8g
a907E48SjOJBGkh6c6B3ace2XH+CyB7+WBsoK6hsrV5twAXSe7frgP4lN/4Cm2isQl3D7vXM3PBQ
ddI2aZzmewTfbgZptt4KCUhZh+t7FGB6ZKppQ++Rx0zsGN1s71MtjJnhXvJyPs9UyL1n7KQPTEX/
07kwIwdMjxC/hpbZmVq0mVccpMy7FYlTuiwFD+TEnhmxGDTVTJ267fcfrySVBHioA7vugeXaX3yL
SqGQdCWnsz5LyCxWvcfI7zjiXJLwefechLp0LWEBIH5+0fJPB1lfiy1DUutGDJTh9WZHeXfVVFsf
rSQ3y0VaTqBESMjYsJnFFYQJ9tZJScBluOYacW6gqPGC6EU+bNYC1wpngwVayaQQMIIGnzCCBIeg
AwIBAgIMaT9V748TBL0gqLOFMA0GCSqGSIb3DQEBCwUAMFIxCzAJBgNVBAYTAkJFMRkwFwYDVQQK
ExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBSNiBTTUlNRSBDQSAy
MDIzMB4XDTI1MDYxOTA4NDMwM1oXDTI3MDYyMDA4NDMwM1owgeMxCzAJBgNVBAYTAlVTMRMwEQYD
VQQIEwpDYWxpZm9ybmlhMREwDwYDVQQHEwhTYW4gSm9zZTEZMBcGA1UEYRMQTlRSVVMrREUtNjYx
MDExNzERMA8GA1UEBBMIRmFpbmVsbGkxEDAOBgNVBCoTB0Zsb3JpYW4xFjAUBgNVBAoTDUJST0FE
Q09NIElOQy4xJjAkBgNVBAMMHWZsb3JpYW4uZmFpbmVsbGlAYnJvYWRjb20uY29tMSwwKgYJKoZI
hvcNAQkBFh1mbG9yaWFuLmZhaW5lbGxpQGJyb2FkY29tLmNvbTCCASIwDQYJKoZIhvcNAQEBBQAD
ggEPADCCAQoCggEBAK9u0aBdl51z/nEmpFSqdvC3Bu87AnBaOq1NGLM4vKTwCRuh1hSPhQOJkIB0
X3lGlHAEUufNmKYb1aeLHW2kToCe+9mr2cBXqHP0aWl/Oy/ZjQabOsXzOzE0SfGLnLfGJMLV7yFB
pwKwqxC8t5MBK+6zhQZGcnnuz9wF1tWGdczOeCmQCTO9+MlB1fNac8pKSB8bUhOSC4fr0ev7BfPA
KmfMr9BBremQmDCaHeTwYy6wZLdj4dZzGMfF6PZOLiV5DU61ehA+spBd00RbowgJfmI525dEWihB
DaLZim3cCy0sCU9GfGm2sHUX+3B0S6twomZzsrTE02PfoUuxXAqf0gMCAwEAAaOCAeEwggHdMA4G
A1UdDwEB/wQEAwIFoDAMBgNVHRMBAf8EAjAAMIGTBggrBgEFBQcBAQSBhjCBgzBGBggrBgEFBQcw
AoY6aHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyNnNtaW1lY2EyMDIz
LmNydDA5BggrBgEFBQcwAYYtaHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyNnNtaW1l
Y2EyMDIzMGUGA1UdIAReMFwwCQYHZ4EMAQUDAzALBgkrBgEEAaAyASgwQgYKKwYBBAGgMgoDAjA0
MDIGCCsGAQUFBwIBFiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzBBBgNV
HR8EOjA4MDagNKAyhjBodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjZzbWltZWNhMjAy
My5jcmwwKAYDVR0RBCEwH4EdZmxvcmlhbi5mYWluZWxsaUBicm9hZGNvbS5jb20wEwYDVR0lBAww
CgYIKwYBBQUHAwQwHwYDVR0jBBgwFoAUACk2nlx6ug+vLVAt26AjhRiwoJIwHQYDVR0OBBYEFCuk
Rbf0cgc52/dpv3u8tk5QBzfLMA0GCSqGSIb3DQEBCwUAA4ICAQCEf8H6iR/fp2Yv2FycUR0XNfkZ
5C5jGago+UGEiNDE1ZEz27RO9dIuFrh6TPwC7Z9zkRxSSEPoXEF9UmaNZpUK9hIOLja4nh2xD83z
udss8gNXHS7AePBy6asDTxJVl+S+Ls7j1mr9udBw4WCD6pSa8PfyTKjG+zhD6BWxBuajysSfyXNJ
lQkOmI4EW0SH3VOIIwZRb1QjxFhPyJI6rqp4osvjzNY3YFtK/F1ylmGI5m0RkwtqgJ/0Lx115i9U
uIo/v/g1BPD0rQqHpVtLvfH4s75U0vw8Cd+Wg7QQUk21PxweqcwnuFakkHi6xarxwnlijKgv9vZn
5p3Gf6TWVrCD7mXWDbl4D+KndfIa6E7hc4xPUA+idcQ02s1s6lfZ36s9f/5ZY9L+BwR12LFvzKcf
JhVO78ugQDvSIrbq4lgDk4HILUi7se+UWdSWg/GvaglFs28PE9DoxG3MOX4wrbXPqpD3lrnZDFMM
uPID5U7ukJqoVbHLZU3u11CcI5k9ko1s9A1Q11sOaUcJHvma/vYz0K0mub0Li4MBym/O5K+kJ98p
sguXKkldCDDtyTm5mFBVXOqbXFDn/oBPRIcHEgjXf8xZVEU6Sh90+k87Vm91WZMWona3POJKJVhe
9sd9RXscJiiFPaZ7E2d3IHNuRetYSfVr9qZl1mOcJIB1i0f1djGCAlcwggJTAgEBMGIwUjELMAkG
A1UEBhMCQkUxGTAXBgNVBAoTEEdsb2JhbFNpZ24gbnYtc2ExKDAmBgNVBAMTH0dsb2JhbFNpZ24g
R0NDIFI2IFNNSU1FIENBIDIwMjMCDGk/Ve+PEwS9IKizhTANBglghkgBZQMEAgEFAKCBxzAvBgkq
hkiG9w0BCQQxIgQgtguLygfxrhNVB5QxIrqOmU3TKZb0RS+lv6/SRrX5y/UwGAYJKoZIhvcNAQkD
MQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjYwNzIwMTY1NzQ4WjBcBgkqhkiG9w0BCQ8x
TzBNMAsGCWCGSAFlAwQBKjALBglghkgBZQMEARYwCwYJYIZIAWUDBAECMAoGCCqGSIb3DQMHMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAM1zD0L0ncmDI2wRKYbl8
JviwICpNTu+KvZmGHgJ01EgRGTQTl+TlaHjor7ZJjSGL94ONfk4u+OSPFxl1k7X0fOJZ9J3WdqPY
iqEGmAg1cdZiNbn5CQfI8hk9QTjcSgV8H+KOgn+dqQi0BTv1mV8jPBwKZ0UX9ZyFG1mPlrJO7v+J
3I4xKhMc631DjZsHCT6gTfQsDF0SBIaa+QKO21XvCLerkI6LtLo7DzhTfAE6Vd1NHQevLNuhTlLv
d/h1BxvQIJc97rb5x07u/UBMKq3gxiMtwI0PvkNf+Ua/bD40kILyqMKy19Irt6lue2vEsJujyrGh
BfXSj9p9JApFuOIoJw==
--00000000000061125006570dce22--
