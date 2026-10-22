Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.93
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792673462;
	b=pH86wIUeFg4cKeU0SpGDiK5eERg/uH8zAiBwFFBwXHafDcA5wBQiX2JcT2P/oAkIh4Mh
	 oUJBT64E28KhCknIz1bcILLdRJSlZPAW/ZFyWk0MmsnjqCw1G8pDx4lTK7GmpHxhXAKqJ
	 fFxKZ/Xnb0QrHQYvJqHKjOCAXNb0QQjXGBUQfT7EurWztTP5dvarJo6FrsT46IPtfLdjd
	 VkRAm4/4FlpGAqphHTovFmrGuRIfwjL20phvaczzqVMl9jr1ibbizQRB7MXW5IFZK03bv
	 Ka/QsP70bk+vRpGbeK1d7V3xwkBxRUMgcg4b4u2OJimgU16LX34ndoX25kiRtEXg3TQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792673462;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=6jubY5/jjzQ8tuOwzuRmqBDvQIqz0kDbItlUUnX+i5w=;
	b=krpD6yqFmzvoQHv59WnLwyGhtxQnd4SWoa1NeRKWja9vThqEl+sHBbMFgDsjtz9J5Hgp
	 3cO6HTebz7NjDqrBlnarl5E/eO5lUI6lnhYry8PfKQLTAY+N8KZji4QxrUhlmAQEiv8Sq
	 WWe0om2zedPPbG1nJzjofcvnCv/95L1wDNSHsSbymKd5eJd72pUKbGotoMSHa0XkgHPme
	 0sFcSh17TJ+4MgU1t3CuJelfRr1yLfYBPctp4/JN+plCsxaeEmTnVvBb17KimKmArLwl9
	 uwyyjFeokzsoibYgwDi5b5QitSE2pCJ003A7GRm0VHI6N8ZiH8fgUas148MbUv/nu+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=mFI8I6aR;
	arc=none smtp.remote-ip=95.215.58.93
Received: from mta1.migadu.com (out-93.mta1.migadu.com [95.215.58.93])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3391606A322
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 12:51:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C3391606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=mFI8I6aR
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=spKMJFioSCArVqJ02iuuvERXVsHVShBgPL1lZ41Z1f8=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792673460; v=1; x=1793278260;
 b=mFI8I6aRrnJRg/9r9ZgFyfwkum2XN1t9nuj6l1PK870EefnE1YTHNWFbmE2BfEuTcgjjikXV
 WYZI/GYX6kTwRwGzYNRxwdHWI6me3AmmpDac6qWmKXPj8Nhq6IJzLzp/0kLeg0/11JUzqiiL6ta
 yaVVe6w4y8/Nt2e5pSI517lY=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 709fad6a2ba1a8cd;
	Thu, 22 Oct 2026 12:51:00 +0000
X-Mizu-Trace-ID: 709fad6a2ba1a8cd
X-Migadu-Flow: FLOW_OUT
Message-ID: <f97b13ca-90b2-4bac-91bb-70c9d26095f9@linux.dev>
Date: Thu, 22 Oct 2026 20:50:57 +0800
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
Subject: Re: [PATCH net] tcp: limit tcp_tso_rtt_log to a valid shift count
To: netdev@vger.kernel.org
References: <tencent_53CDCF8AA0022B75CF72A294CB9993D2FF07@qq.com>
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <tencent_53CDCF8AA0022B75CF72A294CB9993D2FF07@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 10/22/26 8:27 PM, Yingjie Wang wrote:
> tcp_tso_autosize() right-shifts the u32 returned by tcp_min_rtt() by
> sysctl_tcp_tso_rtt_log. The sysctl uses proc_dou8vec_minmax() without
> an upper bound, so it accepts values through 255. Values above 31 make
> the shift undefined.
>
> A process with CAP_NET_ADMIN in the target network namespace can set the
> per-netns sysctl. With CONFIG_UBSAN_SHIFT=y, setting it to 32 and sending
> TCP data over loopback triggers:
>
>    UBSAN: shift-out-of-bounds in net/ipv4/tcp_output.c:2264:30
>    shift exponent 32 is too large for 32-bit type 'unsigned int'
>    Call Trace:
>     __ubsan_handle_shift_out_of_bounds
>     tcp_tso_segs
>     tcp_write_xmit
>     __tcp_push_pending_frames
>     tcp_push
>     tcp_sendmsg_locked
>
> Limit the sysctl to 31, the largest valid shift count for a u32, and
> document the accepted range. Writes of larger values now fail with
> -EINVAL.
>
> On a UBSAN/KASAN build of the net tree, values 0 and 31 remained
> accepted, values 32 and 255 returned -EINVAL, and TCP traffic with the
> valid boundary values produced no sanitizer diagnostics.
>
> Fixes: 65466904b015 ("tcp: adjust TSO packet sizes based on min_rtt")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yingjie Wang <1075151112@qq.com>
> ---
>   Documentation/networking/ip-sysctl.rst | 2 ++
>   net/ipv4/sysctl_net_ipv4.c             | 2 ++
>   2 files changed, 4 insertions(+)
>
> diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/networking/ip-sysctl.rst
> index 8edd2eb2a..66a54c510 100644
> --- a/Documentation/networking/ip-sysctl.rst
> +++ b/Documentation/networking/ip-sysctl.rst
> @@ -1128,6 +1128,8 @@ tcp_tso_rtt_log - INTEGER
>   
>   	If you want to use the old autosizing, set this sysctl to 0.
>   
> +	Possible values are [0, 31], inclusive.
> +
>   	Default: 9  (2^9 = 512 usec)
>   
>   tcp_pacing_ss_ratio - INTEGER
> diff --git a/net/ipv4/sysctl_net_ipv4.c b/net/ipv4/sysctl_net_ipv4.c
> index e3760daa3..e95431140 100644
> --- a/net/ipv4/sysctl_net_ipv4.c
> +++ b/net/ipv4/sysctl_net_ipv4.c
> @@ -26,6 +26,7 @@ static int ip_local_port_range_max[] = { 65535, 65535 };
>   static int tcp_adv_win_scale_min = -31;
>   static int tcp_adv_win_scale_max = 31;
>   static int tcp_app_win_max = 31;
> +static int tcp_tso_rtt_log_max = 31;
>   static int tcp_min_snd_mss_min = TCP_MIN_SND_MSS;
>   static int tcp_min_snd_mss_max = 65535;
>   static int tcp_rto_max_max = TCP_RTO_MAX_SEC * MSEC_PER_SEC;
> @@ -778,6 +779,7 @@ static const struct ctl_table ipv4_net_table[] = {
>   		.maxlen		= sizeof(u8),
>   		.mode		= 0644,
>   		.proc_handler	= proc_dou8vec_minmax,
> +		.extra2		= &tcp_tso_rtt_log_max,
>   	},
>   	{
>   		.procname	= "ip_early_demux",


Wait a minute, is my tree too old, or did you land tcp_tso_rtt_log_max
in the wrong place?

It looks like you are adding it to the ip_dynaddr entry. tcp_tso_rtt_log?

     {
         .procname    = "ip_dynaddr",
         .data        = &init_net.ipv4.sysctl_ip_dynaddr,
         .maxlen        = sizeof(u8),
         .mode        = 0644,
         .proc_handler    = proc_dou8vec_minmax,
     },
     {
         .procname    = "ip_early_demux",
         .data        = &init_net.ipv4.sysctl_ip_early_demux,
         .maxlen        = sizeof(u8),
         .mode        = 0644,
         .proc_handler    = proc_dou8vec_minmax,
     },

> base-commit: f4377bf85887f57b59abb5479f7660a81ffe4449
