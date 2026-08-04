Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12CF331EB5
	for <netdev@vger.kernel.org>; Tue,  4 Aug 2026 18:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785866762; cv=none; b=HUZlhBS3zAvWdxyl4mu3nkwzAaEkd6kRvVajPc/celgZqNMC2PWr5+k193i7WIHmhl7z5G4AQGDOQpmtFexNVOMSncfGif3JPHAkNknoNTNWtCFe5ncBsI89VZkJ0knEGDKf5rJyq9beFdP5T/aiHlVR+mgJNr2cxK23bfSMXTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785866762; c=relaxed/simple;
	bh=mukZbijvR09Qyb8O6a5zSs66Nc1Ea8eJ76KYS4fy0x0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y8HDwk1BIEed3MX2FrJVtXlbfZiPnsOBdtvOy0vTjy/Ko+CX9FmKp2cKQZUh84DgNSsxGSJh5uWEPql4QuqI1FY8NvuOnuCOsW3WkhQ4V+/JoRKoTSZyof7PRFaP/czuCxmeaNqeBGoRXx9UDj3VcXKDJMc09OxNNyvjN9qpbCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T/XJod1g; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T/XJod1g"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-92e7632b193so10466885a.2
        for <netdev@vger.kernel.org>; Tue, 04 Aug 2026 11:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785866760; x=1786471560; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PvFOPFIKv7IZLYV82VSUnHCVCbk2jO9N6jmpfHOfts8=;
        b=T/XJod1gvh20p2DW/AdAWJ74EQT6tre1gp5whPlqrYD3PiIEjglyZGXneLDTjxaYuh
         kfyggTEifzO1Epx13eyNGjHVTWHDsKXWH7X9Y+bE4JG1zVMdZF8EVdvRuvTtLKvJr/lH
         vHnivznxdcM2TXrBNQelgkRj6iZv+L/BfB7E+UKM+PUMTCoD/TufPWpJcgiqmfMKmx1G
         8e0ifEX+lXUADOzM/zVGLipW0fDsyVn6tBoIW6LSJ/DOtun8ixat62anId6TbOJgiOcb
         Wjbp+/SJtDyBdSa6rc2sdF6mJczvVYUkvL7CDlABZczuhp2VQ/yI1YNlDT/+i6Y1gt72
         EUUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785866760; x=1786471560;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PvFOPFIKv7IZLYV82VSUnHCVCbk2jO9N6jmpfHOfts8=;
        b=P90v67RB9Ku8om8eCCM6fIijtUAglMHHLTbNY8+/jnrvsVwpJ+DMiHrFFxU5wT7GAD
         4/DFJVXII0Ydt0GVxle1ukCbPtA1Nz7elyTrOrZGnFhgM06UYoY5BiEc8Ilj/6UK9FnL
         OngT1xRJ3esjrXUjzKKi8XIfAthogD8o61WOnlRDb4NQKGFNLwzUMfAvSLIm9MzMOSP1
         XcP8HAwEK5YnIgfD+CGLoN5reIW9dhyHJBji7B/hVQIK/HQ6pqR9/Kpc6jW2hhenR6AC
         DBYiv0SLKLv4XMKjr/Nj7Impcvw6GbOc23Ec0GhqrSqLUtQ/DyK+YoUNNs7DRXhk5Bdr
         433A==
X-Forwarded-Encrypted: i=1; AHgh+Ro66+qr7LipT9gtBI6U3AFqBMEcsrp184nGBAOv4dLOni+b5mf3KMSr5MV5NGCBxmlmrllNyyo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyphGi612tkc0OIQnoBBBeSApP2StIM0esX3Dthd+fvkaU+KRYw
	fbTnUaVQ9H0XdYL1PHeIz6ln4HLqFi9V9PSjGfPs7TR2U3eBcH8+mQvF
X-Gm-Gg: AR+sD12H9DidwYSsgpBWITrgA3v7jmxmblNNdapPhI9dFpFHZMisFZehbcYUjuKUcZS
	Srzqhu79wnAHSogSCpZypJS3rmVKuBvkfssMPE63dJ2oG1t8iICTxUEywk+uZbDzmS1x93wXNGO
	p4QvUU/aroRcEYVCLwdZXocVUxP7/YbmrbLAzy+B3Ne7hFrho8zRajErqKzbZaU7sGVt4ZXrMoR
	HBYLdkJSo/oxGEDu4BCNkjipG1ttno25babpYy0xjj9wDQ41VoGqStljEam68AirmnH4w2OVbQh
	kv5aDPIxN94iXOUSRQWnxgVnzfSkl+TN+KeyDXXBHdLMtauFHLVH8cpV+8NttGMdhPg5C4S0c2i
	JkukwMyVIsV8PdmqiN68wB5H6Nc8fxcKVSYyTxCHAKH1DeNgw8Aq7H1HvCHL4Y2EZgb0z1vFE6n
	4LPxrze3zwsJgSmOrxY8LIPJC0zjtw8BovJhhl8kk5kR+YscoElToLMVfaELe+3R15DkRG81ZQ1
	7pCpgT1jcRVorAeYp11yvqPelfvTjat7Hz6dRGMPDQ=
X-Received: by 2002:a05:620a:40c2:b0:934:aa05:f549 with SMTP id af79cd13be357-936491d3c8fmr16849585a.25.1785866759759;
        Tue, 04 Aug 2026 11:05:59 -0700 (PDT)
Received: from ?IPV6:2600:4040:9399:4000:e553:72e5:7d37:c7ef? ([2600:4040:9399:4000:e553:72e5:7d37:c7ef])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93641592964sm148846885a.0.2026.08.04.11.05.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Aug 2026 11:05:59 -0700 (PDT)
Message-ID: <9460e089-ed71-4f3c-986c-5d29b87b3500@gmail.com>
Date: Tue, 4 Aug 2026 14:05:58 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next V2 13/13] selftests: drv-net: psp: Add a test for
 PSP with HW-GRO
To: Tariq Toukan <tariqt@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>, Sabrina Dubroca <sd@queasysnail.net>
Cc: Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Alexei Lazar <alazar@nvidia.com>, Boris Pismenny <borisp@nvidia.com>,
 Carolina Jubran <cjubran@nvidia.com>, Chris Mi <cmi@nvidia.com>,
 Cosmin Ratiu <cratiu@nvidia.com>, Doruk Tan Ozturk <doruk@0sec.ai>,
 Dragos Tatulea <dtatulea@nvidia.com>, Gal Pressman <gal@nvidia.com>,
 Jacob Keller <Jacob.e.keller@intel.com>, Jianbo Liu <jianbol@nvidia.com>,
 Kees Cook <kees@kernel.org>, Lama Kayal <lkayal@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-rdma@vger.kernel.org,
 Mark Bloch <mbloch@nvidia.com>, Patrisious Haddad <phaddad@nvidia.com>,
 Raed Salem <raeds@nvidia.com>, Rahul Rameshbabu <rrameshbabu@nvidia.com>,
 Saeed Mahameed <saeedm@nvidia.com>, Shuah Khan <shuah@kernel.org>,
 Shuah Khan <skhan@linuxfoundation.org>, Simon Horman <horms@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>,
 Stanislav Fomichev <sdf.kernel@gmail.com>
References: <20260804083535.2946459-1-tariqt@nvidia.com>
 <20260804083535.2946459-14-tariqt@nvidia.com>
Content-Language: en-US
From: Daniel Zahka <daniel.zahka@gmail.com>
In-Reply-To: <20260804083535.2946459-14-tariqt@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/4/26 4:35 AM, Tariq Toukan wrote:
> From: Cosmin Ratiu <cratiu@nvidia.com>
> 
> Add a test case which attempts to send several 64K chunks over PSP,
> which is more than MTU, and thus trigger GSO on the TX side and HW GRO
> on the RX side. Verify HW GRO counters increase.
> 
> This required the addition of a new command in the psp responder, so it
> sends the data in order to get it reassembled on the local (DUT) side.
> 
> Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
> Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> ---
>   tools/testing/selftests/drivers/net/psp.py    | 131 ++++++++++++++++--
>   .../selftests/drivers/net/psp_responder.c     |  49 +++++++
>   2 files changed, 171 insertions(+), 9 deletions(-)
> 
> diff --git a/tools/testing/selftests/drivers/net/psp.py b/tools/testing/selftests/drivers/net/psp.py
> index 315648a770d0..9b899723a635 100755
> --- a/tools/testing/selftests/drivers/net/psp.py
> +++ b/tools/testing/selftests/drivers/net/psp.py
> @@ -16,11 +16,12 @@ from lib.py import ksft_run, ksft_exit, ksft_pr
>   from lib.py import ksft_true, ksft_eq, ksft_ne, ksft_gt, ksft_raises
>   from lib.py import ksft_not_none
>   from lib.py import ksft_variants, KsftNamedVariant
> -from lib.py import KsftSkipEx, KsftFailEx
> +from lib.py import KsftSkipEx, KsftFailEx, KsftXfailEx
>   from lib.py import NetDrvEpEnv, NetDrvContEnv
> -from lib.py import Netlink, NlError, PSPFamily, RtnlFamily
> +from lib.py import Netlink, NlError, NetdevFamily, PSPFamily, RtnlFamily
>   from lib.py import NetNSEnter
>   from lib.py import bkg, rand_port, wait_port_listen
> +from lib.py import bkg, ethtool, rand_port, wait_port_listen, CmdExitFailure

nit: agent has pointed out that this new line is reimporting bkg, 
rand_port, and wait_port_listen from the line above it.
