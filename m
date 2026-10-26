Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793001539;
	b=gPII6Y8iRPh20A/0dYdyc6/H5iC6ONOiVP5SjiV9j7eJsT0Pt4rKu5xulqvhRFyBoYE7
	 m3H8zpBBqV+Ijn/eVmqcWKL+w5NIw/vRTb7208Rs6o4lTe54WRiq4JXCZFpTd+03tUVqX
	 vxIlKz+sphkIKODL9DBFtBs2gQuawwffhAV9h7rKnZWLQLBXfIfWYTAcjbo9Y5Ua46DIz
	 eI+8yyhZDktX4rrseiPRyy/HfwjTVCmhG6uc14KxDhUWn3+2xfG7Uu1O2/lDKDVDiH+bT
	 mXOwzQOEuvvuyrVgGazbZpQOlD3/z7TCISpuejeUdPMkSBesBVF1ONX7fvfRLR0ePbA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793001539;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:Content-Language:To:Cc:References:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=ENqpIp5OCMvGLbQfuRT56moz6XxyZs/DH9YB2R1VAX4=;
	b=AyYKxNLRJp+9rPE8T2UKLk/TG5bqpArR+ZplxqvIl8u1iI3IR/C2a5Kwkfx1UgoyWhtg
	 SN9GKHrl5v1yhbFIsoyJX52MlaV3pEwEChq5ei0bGwdvIQiVCTj8+QKUiuQi4lP2AfwRm
	 KGh0tdtKStQyqQrpvo65v/53HrJF14kLoDMwl6124+GdR4NRXSQRAQaIZ2QE5wtv3EegD
	 nXBE83nxH7QilwXEqJolwLxMVyxuhq9q1ovWr7B/oyzXR8mLsSRbasS4qIUuPBOGFm/ej
	 CyqHaWl1LmRoOIuGsBhOrJxOGwvwzz6DAZj1o3SEzQeySum5pr0i9uVUSUcg4KtHQIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=blackwall.org;
	spf=none smtp.mailfrom=blackwall.org;
	dkim=pass header.d=blackwall.org header.i=@blackwall.org header.a=rsa-sha256 header.s=google header.b=YIkiyv88;
	arc=none smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12B5606A31B
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 07:58:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F12B5606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=blackwall.org header.i=@blackwall.org header.a=rsa-sha256 header.s=google header.b=YIkiyv88
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4a20bdaf39cso27198325e9.1
        for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 00:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1793001537; x=1793606337; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ENqpIp5OCMvGLbQfuRT56moz6XxyZs/DH9YB2R1VAX4=;
        b=YIkiyv88wEEaX9fcSbw7nvWAWwnKoGCpr68rh8SmVrnPxrMcW6i9lXw/gEkPqfFhM2
         Bi1bYj966tUFjI83HwGRD0kb1x4mwoQUdBo0tYT/3xHhIy0pancQ9TR5VXrmUoow3B8W
         RlUhVzzYnLVHUS8XO7S7GNahgM08iD/hnciCfwkxkqAQBRcXVZfX7DvM1JNTgaCtnHir
         fChs2UF2cPdCpY/nM39VMhXhDrQs6MSQRqKmhyLFukXx/c+rGEU13D2cXlwk4+aRI8Xt
         0ElwE487d5xkJZg3S62lGaXygv/SZlDeZIhe3CosQ0+blDs69NwWZ4ywEHW1WjamGOxR
         A37g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793001537; x=1793606337;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ENqpIp5OCMvGLbQfuRT56moz6XxyZs/DH9YB2R1VAX4=;
        b=2VacaJesL8GjBFYb2pkzzpXP2e4l0wJLccy7Giw3Vzr2WyzZQFrSWWKh7Ql6vc2mjz
         3ap6kYmKGB+eeYCVZ3bJMekESdZEgvtz4k8/x836mSO60NFMfSS1pH9+cxWi5QqwpoBP
         373pzJrMQ5oaBvCyD03YWmXMorEC91Ir+TREo4XeoQABLtY5ITZ3sZp3iEd42HNqrUou
         3hjY3pulYGlobsR+hZ8t4vNP/i0v7XUDlUodezuhnkxClc3FCFkGs82CTnWzA10JqpLg
         GbJ39Lp9e3GH3/qxiSnmA4WGjxNzqQArBqD5II5aGVsPNO8QeD4uGzAygYrESWN/8eCk
         pWaQ==
X-Gm-Message-State: AFq9FYKA8l/Tlp+g6KvMqyYIcOiSmPOPqw0yXYsbiruipMjt0KvIdz7k
	EpCLoy1cmnoEuA2OALM0NzOW3IcPdfV96Nclap2u17IrzUtm+AqH42jLeaCUw0bsZZ4=
X-Gm-Gg: AYBFou3BrMMoDzKieFrbD3WIcF9gGmhHnzbgn8uRyX0MEzTvvoiuDj87Z1aC9SMA3/0
	UQvLyyWWGCw3FOnswpaciTluJLA94KuyFQ5kgshcYX9UHyAnYtOab+EAKxTG5oqYZUkoaqpJkmH
	b7ZaN1SPhZebuiI9/jksDhiUAch2Z5s/bRclNjOgWunU3IYqBhfCbG9ZefBVRE7p8k14kKahWDw
	VkTj03eWD2b3qMBShxOPYzYJHdX5mJF/OY5+7o6cwZDM6ePEB15u4rnLJmqWKX8REauWLDCphxg
	2T23mcZ1D0A/dtn/SHY0mI1kAvhE9RzBTxypvmOTbxP5ODBRa6gmqeiIj+UMd9fm7cKr8l8jIS8
	SvAj4NdxgJeRT3c93YMkB1zJohviAn7nTMUVxkLVOa11NFHKli4MBJ2UmwIgCDy9MtEhoNjM+4s
	4iwrX7/Num8ehylA89FI4JbUwzZvlljIaZYIBAyhxC494IDnPe107j7/tJhQt2YKFKi3Db0AtXq
	XK53QS9so9IOYI8FzHFzwCuJxS+AN6BFd7FMDbArqwRMdEKEYE1kqqEdFriDgdECld50f3/YE7W
	I7vNGKpAHg==
X-Received: by 2002:a05:600d:c:b0:4a3:7344:13b5 with SMTP id 5b1f17b1804b1-4a373be2a9emr75329375e9.16.1793001537419;
        Mon, 26 Oct 2026 00:58:57 -0700 (PDT)
Received: from [192.168.0.161] (78-154-14-127.ip.btc-net.bg. [78.154.14.127])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a35a5697a7sm170954675e9.7.2026.10.26.00.58.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Oct 2026 00:58:56 -0700 (PDT)
Message-ID: <c561b8e2-40f3-48d4-8f2f-85b46163466b@blackwall.org>
Date: Mon, 26 Oct 2026 09:58:55 +0200
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
Subject: Re: [PATCH net 2/2] selftests: forwarding: vxlan_reserved: add gbp
 changelink test
Content-Language: en-US, bg
To: Hannes Laimer <h.laimer@proxmox.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Ido Schimmel <idosch@nvidia.com>,
 Petr Machata <petrm@nvidia.com>, David Ahern <dsahern@kernel.org>,
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20261023-b4-vxlan-changelink-gbp-v1-0-f0d13951c09b@proxmox.com>
 <20261023-b4-vxlan-changelink-gbp-v1-2-f0d13951c09b@proxmox.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20261023-b4-vxlan-changelink-gbp-v1-2-f0d13951c09b@proxmox.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 23/10/2026 14:14, Hannes Laimer wrote:
> On a device created with gbp, run the reserved bit probes before and
> after an unrelated changelink. Check that what the device accepts has
> not changed.
> 
> Signed-off-by: Hannes Laimer <h.laimer@proxmox.com>
> ---
>   tools/testing/selftests/net/forwarding/vxlan_reserved.sh | 15 +++++++++++++++
>   1 file changed, 15 insertions(+)
> 
> diff --git a/tools/testing/selftests/net/forwarding/vxlan_reserved.sh b/tools/testing/selftests/net/forwarding/vxlan_reserved.sh
> index 709845123727..0ce264cc57f8 100755
> --- a/tools/testing/selftests/net/forwarding/vxlan_reserved.sh
> +++ b/tools/testing/selftests/net/forwarding/vxlan_reserved.sh
> @@ -40,6 +40,7 @@
>   	reserved_31_test
>   	reserved_56_test
>   	reserved_63_test
> +	gbp_changelink_test
>       "}
>   
>   NUM_NETIFS=4
> @@ -338,6 +339,20 @@ reserved_63_test()
>   	    reserved_test 63
>   }
>   
> +gbp_changelink_test_do()
> +{
> +	vxlan_device_add gbp
> +	__default_test_do 25 "gbp"
> +	ip link set dev vx1 type vxlan ageing 300
> +	__default_test_do 25 "gbp after changelink"
> +}
> +
> +gbp_changelink_test()
> +{
> +	in_defer_scope \
> +	    gbp_changelink_test_do
> +}
> +
>   trap cleanup EXIT
>   
>   setup_prepare
> 

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>

