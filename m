Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793528587;
	b=QSRF0G9zH4Ta82leWazJs17za/XLEN29UkYaejWdQ70111tcLl6HkvDzKD0v/kK4fOCn
	 IRc5xSL4WkED0SjVWpqxsiKuGqLozr5gR0I0OehvxzI1PoR50iP31/78g7n84+Qm9WWHt
	 wUGaL35flfYtH6xSt7zo2dFRx499d7Ra0b2fjvla/SUITFdKu2tVXZmyFu6NK4OueJexG
	 cnZsY4Vw6/jhzNjcT9E6esqikfOwCU2Kw22jGQOY5hSaxkOmhF9hvxEzD5Gw/YAeFyZeX
	 g8TsmR3v8ysNcqrlF8cg3t0bOP+wZxrp24QiBKNgzzK4i3nkJ+Mt6Ecv0R3/fwE9FWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793528587;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:Content-Language:To:
	 Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=msvOHl/vwSgu8PRO+tkgo4NL+2qt01hm6ZSBcN1ALqQ=;
	b=M/cYFZt17j2XdGG+cSA9kR0isTVkb3nma58RYds5a7WUgfxiFh8mZkZkoAo4EYuXX8hU
	 A5hCKB+9tTMstJXUICaCpjBXBVQFmgocwuSkNHG5iIuEc3z2xuhK9xmCfPt1Nb+R2R0/H
	 G0eN3dHmoAeKPTz+BCa3o48tOfblbHD3l4KC9UClLHFP3FCxr2g1LO9agog1ly+FgmlCC
	 BxgWzrj4+JK8fZTjz+Zuu3bx2UL3uLkgrNsuLOx/m9fMZKKDdThn3n5MvYK0kCgjC6EKV
	 GHik/rksszHRcLt/WTHKXM6jv7939+tweJdKMsB0dJs+4ZlBhZrxee4GyidiBB2S15A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=blackwall.org;
	spf=none smtp.mailfrom=blackwall.org;
	dkim=pass header.d=blackwall.org header.i=@blackwall.org header.a=rsa-sha256 header.s=google header.b=IbBQEbE7;
	arc=none smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E470606A325
	for <netdev@vger.kernel.org>; Sun,  1 Nov 2026 10:23:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6E470606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=blackwall.org header.i=@blackwall.org header.a=rsa-sha256 header.s=google header.b=IbBQEbE7
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4a2069b9710so17565465e9.2
        for <netdev@vger.kernel.org>; Sun, 01 Nov 2026 02:23:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1793528585; x=1794133385; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=msvOHl/vwSgu8PRO+tkgo4NL+2qt01hm6ZSBcN1ALqQ=;
        b=IbBQEbE7feKVZTBcHrbcmXeLAJoNrm+yN//hxFKgtmcm3daxC97LETn7Po6C6wjVOI
         n7OAsHkd4fJTGHumh0e7J5PQSfLnBEgMt+twh8xAhLbGWA4AW3iTvM8JJ/VOL2KpNifz
         flc0/3HDjXu7SPviS92yKsjlzUhMDMbeupymAhrZxJioYV0qg5eR2w3pyXvSbbzTpCJI
         R2X6mgOW5hwasaKBXsGaw4zKdZ9rfT+QFixNR4rT+Ylth8u6GCa+71rD41AMZ7HlHSxl
         Fb4MrOXS3sd6t0Z96W6k4xi2g0HwPJ9uZEXvpLCKYZZ01ROU7TX/WCCy40SjRjBzVnzD
         85Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793528585; x=1794133385;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=msvOHl/vwSgu8PRO+tkgo4NL+2qt01hm6ZSBcN1ALqQ=;
        b=hKsVgWqQnOfkiTStP2JVD8hmD+yPDwzXw9IuxG3gqMy9rL8WH5GKwenPJCUlKTA/hF
         78GaOmffMcj9d838sA7WAsJ8OTxv7n0gBz/MqluV4HQ/ppKDypA9D1o5vOQGYdwMZlkE
         W2Jvr5ZSKU+BWyWwkHiBFkHHeA0Hj8vYaFphYqiJwrQvnoiP+rp9BzOVlH4oMTK1Dl9B
         FuvcbHNDr6VsseYl794AWS4XYp72IntZZv3W2IjFLEUdLITp2rngaIKpPHP/1eyKfOQQ
         4cZk3XrDtbO1tuBSjJXx6uUPFVjH+9Gux0T1klLVFYeK9mi74Ts+ReMIV+AJyeihP+Tf
         18+w==
X-Forwarded-Encrypted: i=1; AKwUvBy7nSnhhBCXI0KUX3vdkr5V4SNED8hfkmWPOiBAydiGPb5eCRYbLId/KE/cQzMd1oZiKbqR3oQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYJgCTVCvF2BskdNGcyHswpyYlZAdluDbezlKk5p+bik//FrDJSK
	XweNQMii09k7oYIoAVEOBVtdAzZfLnDkCspTOk9ZQPuQvs0Glj7Qm36lO1EqJdj45v0=
X-Gm-Gg: AYBFou2Vmp8qEzNRpPK8TZKVufliYXi8NNOF7rsxv2wkyaxAJ1C4vKh+Ae6Ycml2rst
	ggBA7IdF5O64payzbXeuBbXOQ2dfoAg6rI2MLyoDa5Aj204fUINpYKlmtjscNyd0xvXxOvo2LGw
	8R/Go8WIlDES3bGMRP3D71VkokeG0w2HSYIzsXRzmlDrakaRkzPYtfxYWK6iufrx3gebXe40xx3
	rTWl0WyE1gUirWLszq+7HgsGK9fmV8ja8AZ4o8pCGCYUAXBTyT3PJWbAq7nHyQNEL94+voskd7B
	kgBUICWkRNLelcGHAzonQWUoFsf7ONg+CC6f5gsuoh97mPL2bTRCmre/I2sgG46NAD5cTerygaY
	SMyFR+o+I+I+FBkzObW+/4wLOxywRy1Z0a59m2wDS2WXZB5A0NcXf3LKQ1wRACvahLRzb1v3tEL
	k+lccFxW5FfFJuWmticTb8IWgcyZg3wTqk4GngV7TJSI1kjgb3NfAl9zsQA99tp27ZQX91hbc59
	Vwm3GElbI3wpxDhh4uQngUHLUw2exCrjzvLKTJ/0t41Mb/QhbitJ+ja6epa03pXskEcVkqb5O2T
	eUmSvb5DUbWvwSEmYeKj81OY5ibgVZugbLoff6oFEVnbVJhZ0KMRVGYbUA==
X-Received: by 2002:a05:600c:46d2:b0:4a1:7ec7:a479 with SMTP id 5b1f17b1804b1-4ac1980118cmr155693645e9.33.1793528584150;
        Sun, 01 Nov 2026 02:23:04 -0800 (PST)
Received: from [192.168.0.161] (78-154-14-127.ip.btc-net.bg. [78.154.14.127])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ac0a66caefsm151902005e9.5.2026.11.01.02.23.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Nov 2026 02:23:03 -0800 (PST)
Message-ID: <f7e54e22-c117-455b-9bfb-9dc728dce740@blackwall.org>
Date: Sun, 1 Nov 2026 12:23:01 +0200
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
Subject: Re: [PATCH net v3 3/5] ipv6: restrict mld_qrv to 255
Content-Language: en-US, bg
To: Jiayuan Chen <jiayuan.chen@linux.dev>, netdev@vger.kernel.org
Cc: stable@vger.kernel.org, Fernando Fernandez Mancera <fmancera@suse.de>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap
 <rdunlap@infradead.org>, David Ahern <dsahern@kernel.org>,
 Ido Schimmel <idosch@nvidia.com>, Thomas Gleixner <tglx@kernel.org>,
 Joel Granados <joel.granados@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>,
 Kuniyuki Iwashima <kuniyu@google.com>, Maoyi Xie <maoyi.xie@ntu.edu.sg>,
 Gerd Rausch <gerd.rausch@oracle.com>, Oleg Nesterov <oleg@redhat.com>,
 Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>,
 Yung Chih Su <yuuchihsu@gmail.com>, Wyatt Feng
 <bronzed_45_vested@icloud.com>,
 Hannes Frederic Sowa <hannes@stressinduktion.org>,
 Flavio Leitner <fbl@redhat.com>, "Paul E. McKenney" <paulmck@kernel.org>,
 Petr Mladek <pmladek@suse.com>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261101061331.286404-1-jiayuan.chen@linux.dev>
 <20261101061331.286404-4-jiayuan.chen@linux.dev>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20261101061331.286404-4-jiayuan.chen@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 01/11/2026 08:12, Jiayuan Chen wrote:
> net.ipv6.mld_qrv only has a lower bound, but ipv6_mc_reset() stores it
> into the u8 inet6_dev::mc_qrv, so 256 wraps to 0 and the first MLDv2
> Query received on the interface trips the WARN_ON() in mld_update_qrv():
> 
> 	WARN_ON(idev->mc_qrv == 0);
> 
>    WARNING: net/ipv6/mcast.c:1327 at mld_query_work+0x1fd2/0x2cb0, CPU#3: kworker/3:1/2688
>    Workqueue: mld mld_query_work
>    RIP: 0010:mld_query_work+0x1fd2/0x2cb0
>    Call Trace:
>     <TASK>
>     process_one_work+0x93a/0x1b20
>     worker_thread+0x6d0/0x11d0
>     kthread+0x358/0x470
>     ret_from_fork+0x5b3/0x820
>     ret_from_fork_asm+0x1a/0x30
>     </TASK>
> 
> Make the sysctl a u8 like mc_qrv and switch to proc_dou8vec_minmax(),
> which rejects anything above 255, and document it.
> 
> Fixes: 2f711939d2ea ("ipv6: add sysctl_mld_qrv to configure query robustness variable")
> Cc: stable@vger.kernel.org
> Reviewed-by: Fernando Fernandez Mancera <fmancera@suse.de>
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> ---
> v2: switched to u8 and proc_dou8vec_minmax(), as suggested by Kuniyuki
> Iwashima.
> ---
>   Documentation/networking/ip-sysctl.rst | 2 ++
>   include/net/ipv6.h                     | 2 +-
>   net/ipv6/mcast.c                       | 2 +-
>   net/ipv6/sysctl_net_ipv6.c             | 4 ++--
>   4 files changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/networking/ip-sysctl.rst
> index 4b19c8d3efda7..71f334f27004e 100644
> --- a/Documentation/networking/ip-sysctl.rst
> +++ b/Documentation/networking/ip-sysctl.rst
> @@ -2515,6 +2515,8 @@ mld_qrv - INTEGER
>   
>   	Minimum: 1 (as specified by RFC6636 4.5)
>   
> +	Maximum: 255
> +
>   max_dst_opts_number - INTEGER
>   	Maximum number of non-padding TLVs allowed in a Destination
>   	options extension header. If this value is less than zero
> diff --git a/include/net/ipv6.h b/include/net/ipv6.h
> index 3de07e738538f..4901a92066e61 100644
> --- a/include/net/ipv6.h
> +++ b/include/net/ipv6.h
> @@ -205,7 +205,7 @@ struct sk_buff *ip6_frag_next(struct sk_buff *skb,
>   
>   /* sysctls */
>   extern int sysctl_mld_max_msf;
> -extern int sysctl_mld_qrv;
> +extern u8 sysctl_mld_qrv;
>   
>   #define _DEVINC(net, statname, mod, idev, field)			\
>   ({									\
> diff --git a/net/ipv6/mcast.c b/net/ipv6/mcast.c
> index ecef55f261890..13f31132e0f97 100644
> --- a/net/ipv6/mcast.c
> +++ b/net/ipv6/mcast.c
> @@ -106,7 +106,7 @@ static int __ipv6_dev_mc_inc(struct net_device *dev,
>   #define IPV6_MLD_MAX_MSF	64
>   
>   int sysctl_mld_max_msf __read_mostly = IPV6_MLD_MAX_MSF;
> -int sysctl_mld_qrv __read_mostly = MLD_QRV_DEFAULT;
> +u8 sysctl_mld_qrv __read_mostly = MLD_QRV_DEFAULT;
>   
>   #define mc_assert_locked(idev)			\
>   	lockdep_assert_held(&(idev)->mc_lock)
> diff --git a/net/ipv6/sysctl_net_ipv6.c b/net/ipv6/sysctl_net_ipv6.c
> index 1a0a36dcdabc1..f3ac04dbc71d0 100644
> --- a/net/ipv6/sysctl_net_ipv6.c
> +++ b/net/ipv6/sysctl_net_ipv6.c
> @@ -226,9 +226,9 @@ static struct ctl_table ipv6_rotable[] = {
>   	{
>   		.procname	= "mld_qrv",
>   		.data		= &sysctl_mld_qrv,
> -		.maxlen		= sizeof(int),
> +		.maxlen		= sizeof(u8),
>   		.mode		= 0644,
> -		.proc_handler	= proc_dointvec_minmax,
> +		.proc_handler	= proc_dou8vec_minmax,
>   		.extra1		= SYSCTL_ONE
>   	},
>   #ifdef CONFIG_NETLABEL

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>

