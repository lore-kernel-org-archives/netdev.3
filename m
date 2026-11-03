Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793699510;
	b=dC4L8HMQ9hjly6FAeS5C7hSGn2KfjGWcNVnOBmORpehBupggM2Z9/nEZBfv6mmEUCMzi
	 bnDRXxYmGGjdJvS1qPCPmsY3EYEVQRhlujVLltDffiQQ3tOMTMBbl2E3RLpK/5PapkjqF
	 F6ydT4XbeElgGRnDyg4Lx6BCttKmcFj/GtIWEEphpYvXeCZzO927EJfhpGvzAEPrWiw7H
	 bP9bMY5bewPqfbY2A+bysMWvqKSrbOzT8fdyso392g11BCmXIsGzaQF1yX8RKSYBFzC40
	 tBmJR+CEcdcA1h+bUYcJwAF2nNZEuWSof68XXdTksRZ7i6wxhYfYAzXM5jpc0G0utPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793699510;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=bewOnsRcAtkxxhewjr7KULoKEr/vN1zVTJlv/Nr+c58=;
	b=nNNbk3vAVsgwSyxq9NyVM5JiXZeTsM7FzSGZLBB5c8jUnNPyp9mGEsPrSvIxrMHAuVfx
	 AKzqGkJyKAk/AvLlipBkBA8JCVlFSAhmok37Kakt2qAVVdJakXBVTI2pymVsnDxb741W0
	 WKprq7djglXR0pQ1sQCmPQSyLzjc680rLBoKftcQJrynHXj2eepW0Dn9oh6G3+OiJ9OH7
	 SBOVBLsq1V2OHM7dFL/xwgV4NJyQnJDYj1WSDIPq2QtuVuZJhjnDefcJUlEMeGC9aTqOO
	 ln03PMjqIAo707nkZuA/dbjeepCaITzCR0T+8z7Plh1MDFxCC7cOQzLZGYkkvQ/3CpQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b="gY/BRfc9";
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=TRCJqCdg;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2709606A324
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 09:51:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B2709606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gY/BRfc9;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=TRCJqCdg
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793699508;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bewOnsRcAtkxxhewjr7KULoKEr/vN1zVTJlv/Nr+c58=;
	b=gY/BRfc9mWTiG5pp6DezoEnTAAfJEWNB7YlOa0D9AhQxi68BQXrTqdB2Cr1ZtyaQoO8wdv
	gk1hVZXYweZaA2Znavba44gX4Xc/H62BlqeLaU5m7VFtc0WdEBkodEuegnkdRpwbKxwWCx
	Hy0Ep41jGt04Sd+ptv1L2+Dt6q9HBXU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-358-3es06N9MNdC58ldIawo9YQ-1; Tue, 03 Nov 2026 04:51:45 -0500
X-MC-Unique: 3es06N9MNdC58ldIawo9YQ-1
X-Mimecast-MFC-AGG-ID: 3es06N9MNdC58ldIawo9YQ_1793699504
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-48e17d30a79so2077557f8f.3
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 01:51:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793699504; x=1794304304; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bewOnsRcAtkxxhewjr7KULoKEr/vN1zVTJlv/Nr+c58=;
        b=TRCJqCdgysMSYc26xZFInlBQkKL+QibTfoVCKEIj9PIPsW6g7zBqdrBhQzYNJWfAUT
         6oIe0sh0RwXddZF1Iw1wE3bDpavdHrLvwfIsKvV13S3+ElYqqGHGQUhUatqqZSebUSlq
         mrpmMwoI5ycdFmPZjn3z2FqAULrsob/7NqAojpJ+bPdKoft40wyHftPhzjx3N1yE32iZ
         4fMLemfN03t8KVTQ0ftXt7cmutP1skD2ga+2DmkeVwvOCgsiLM23doZapJbQ7YsV8PCS
         uIsTrzCobKmDJJiJgjmLf3Eky374uHrwgFNXhr6YDKffl8QNRg2ZPlzQ+oYti9xg7p6K
         aOug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793699504; x=1794304304;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bewOnsRcAtkxxhewjr7KULoKEr/vN1zVTJlv/Nr+c58=;
        b=pMV4kFG+QIWuFZMwdip3/CjLjpP6dRdMPrM24ptj7RGnGxpGw8k0sk/pjX2t+h0dLh
         MooLswwbqy5ASVIHoqoUIXSkTQg1ai8ILojGAdLBfUdW6AfHA5H8/GTEwOEkwtVM7SYY
         /znRhJtWqwsj7Or/Ci9QGzf0FIV2WUxEjQXAVtc41BhMCLLuLZtvKVhvcLKaeXXvUsAx
         mmiE/nRpByfHy8868L72vkLNnbWOLcSkwQJhBZBjvXS/ZXvkBGaSKPPcWQlv8QccO+wY
         CKykryPd74tW7G2tdnBoTgak+E7Bn+9y5S9WlMZkmt24f4WzlQHKGu1+htb5ZGzAFqQC
         WEMg==
X-Forwarded-Encrypted: i=1; AKwUvBw1L60mHRdOC4G7SjGaMbzqNm6ijCFsNq2MjZirpn7vZ3boJ25no+wY5SBcka7xb7kh+1esU00=@vger.kernel.org
X-Gm-Message-State: APuU4Z9rRlFnU1P1mww/qa6Efikn7tyIcqxNpqoda3WXTNzEuzWQa44p
	61s0aPrCRr+Z3ZOcIB8S1Tv9xbzs3+6TYik3bY2/+M6BWnvz2FhhKcte/8CzR/VxVSX4ZgBpkdG
	jFKKfKA403M1umYbFcCbF8B506zJ6CwLkXEJfSrEETVccQ+I1n7ZYfBXQZKcm5IcUlg==
X-Gm-Gg: AYBFou3/0n8rKGIH2ak09io8rJA2r9UrKeOYeDrIk3ITDP5ld8cFTry3S7prcuTB8de
	wcy+0oNQgm/Bgc2//lTpVRh7RU0KTQdKRIdMvHn6yjB+m1siXtslt5C0TVCVDFPLTbLgw4XNT2f
	/Uh/YcrQDc5exe+nqY1cw+mJo76dCPmAMYablQSGRc/vqu9f5xw6ikj/LlMXew35qB478NAcmzi
	2RvvmIGH/wgf3dN1UUBeUsBp1C4WxZRi+aT7HrYlDZi5WPltN5urTl1aHZKNBW6JshuaxLsuBah
	2J+f1tP/lzUHaBLBA2LiXvZ26+YZPQVzWMRkN4y+z0gYTsX6j1AHmrSh1uvsOhnMnrD/u2FkwHK
	CgQ47GaPlNGc+Dlvawe/7MkQA9MJL1JyvleGOcXuimHrl/4YQNvDf+cKLe82hg3c44beHgVSeFM
	2KxJZKi3eyIIXwNTASVSeUiSyIoSlKO9c8vRty2nUzkX4=
X-Received: by 2002:a05:6000:2c03:b0:48d:f034:7fcd with SMTP id ffacd0b85a97d-48e6e4fca93mr26503035f8f.51.1793699503630;
        Tue, 03 Nov 2026 01:51:43 -0800 (PST)
X-Received: by 2002:a05:6000:2c03:b0:48d:f034:7fcd with SMTP id ffacd0b85a97d-48e6e4fca93mr26503013f8f.51.1793699503252;
        Tue, 03 Nov 2026 01:51:43 -0800 (PST)
Received: from [192.168.88.30] (ip231-128-192-82.pool-bba.aruba.it. [82.192.128.231])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b7270asm24272555f8f.11.2026.11.03.01.51.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2026 01:51:42 -0800 (PST)
Message-ID: <967aa8d5-582f-43bf-a8ff-8ab68aad747e@redhat.com>
Date: Tue, 3 Nov 2026 10:51:41 +0100
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
Subject: Re: [PATCH v2 net] tcp: bound snd_cwnd_clamp to TCP_MAX_SND_CWND
To: netdev-bot+sashiko@kernel.org, edumazet@kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, ncardwell@google.com,
 kuniyu@google.com, horms@kernel.org, netdev@vger.kernel.org, mason@kernel.org
References: <20261030111528.2850082-1-edumazet@kernel.org>
 <179363987528.3131.2987776489427079887@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <179363987528.3131.2987776489427079887@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/2/26 18:17, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 0 · Medium: 1 · Low: 1
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [Medium] BPF struct_ops congestion control programs can still store any
>    u32 into snd_cwnd and snd_ssthresh, skipping both snd_cwnd_clamp and…
> - [Low] Some CC u32 arithmetic can still overflow with cwnd at or below
>    TCP_MAX_SND_CWND, which contradicts the new tcp.h comment saying CC…
> 
> --
> 
> tcp: bound snd_cwnd_clamp to TCP_MAX_SND_CWND
> 
> This patch gives snd_cwnd_clamp a finite default of TCP_MAX_SND_CWND
> (2^20 packets) instead of ~0. It also caps the locked RTAX_CWND metric
> and the TCP_BPF_IW and TCP_BPF_SNDCWND_CLAMP setsockopt paths. The goal
> is to keep the u32 cwnd arithmetic in congestion control modules from
> wrapping.
> 
>> diff --git a/include/net/tcp.h b/include/net/tcp.h
>> index 3560adddf8215..5c9203aae8341 100644
>> --- a/include/net/tcp.h
>> +++ b/include/net/tcp.h
>> @@ -1554,6 +1554,15 @@ static inline unsigned int tcp_packets_in_flight(const struct tcp_sock *tp)
>>   
>>   #define TCP_INFINITE_SSTHRESH	0x7fffffff
>>   
>> +/* Default and maximum snd_cwnd_clamp, in packets.
>> + * A peer can not advertise more than 65535 << 14 bytes, so a larger
>> + * cwnd is useless with any MSS of 1024 bytes or more.
>> + * Congestion control modules multiply cwnd by u32 factors up to 2047
>> + * (cwnd * (BICTCP_BETA_SCALE + beta) in CUBIC), and CUBIC's
>> + * bictcp_update() expects cwnd to stay below about one million packets.
>> + */
>> +#define TCP_MAX_SND_CWND	(1U << 20)
> 
> [Severity: Low]
> Does the "factors up to 2047" sizing hold for CUBIC's bictcp_update()
> with valid beta values?
> 
> cubictcp_register() in net/ipv4/tcp_cubic.c accepts beta in [0, 1023],
> then computes:
> 
> 	beta_scale = 8 * (BICTCP_BETA_SCALE + b) / 3
> 		/ (BICTCP_BETA_SCALE - b);
> 
> For beta=1023 this gives beta_scale = 5458. bictcp_update() then does
> this in u32:
> 
> 		delta = (cwnd * scale) >> 3;
> 
> With that scale, the product wraps for cwnd above about 786,906, which
> is below TCP_MAX_SND_CWND. For cwnd = 800000, delta comes out as
> 8,929,088 instead of 545,800,000. The ack_cnt loop then inflates
> ca->tcp_cwnd and pushes ca->cnt down toward 2, so cwnd grows too fast
> near the clamp.
> 
> beta is also module_param(beta, int, 0644) in both tcp_cubic.c and
> tcp_bic.c, and a write at runtime is not validated. If beta > 1023 is
> written later, cwnd * (BICTCP_BETA_SCALE + beta) in
> cubictcp_recalc_ssthresh() can wrap at cwnd = 2^20.
> 
> In BIC, beta=4096 makes cwnd * beta in bictcp_recalc_ssthresh() wrap to
> 0 at cwnd = 2^20, which returns an ssthresh of 2. That beta value makes
> no sense anyway, though.
> 
> All of these need privileged module tuning, and the effect stays within
> CC behaviour.

My understanding is that the last sentence makes this comment mostly
irrelevant.

>>   static inline u32 tcp_snd_cwnd(const struct tcp_sock *tp)
>>   {
>>   	return tp->snd_cwnd;
>> diff --git a/net/core/filter.c b/net/core/filter.c
>> index 09c60a58c82ab..96f9ba67095a2 100644
>> --- a/net/core/filter.c
>> +++ b/net/core/filter.c
>> @@ -5590,11 +5590,12 @@ static int bpf_sol_tcp_setsockopt(struct sock *sk, int optname,
>>   	case TCP_BPF_IW:
>>   		if (val <= 0 || tp->data_segs_out > tp->syn_data)
>>   			return -EINVAL;
>> -		tcp_snd_cwnd_set(tp, val);
>> +		tcp_snd_cwnd_set(tp, min_t(u32, val, tp->snd_cwnd_clamp));
>>   		break;
>>   	case TCP_BPF_SNDCWND_CLAMP:
>>   		if (val <= 0)
>>   			return -EINVAL;
>> +		val = min_t(u32, val, TCP_MAX_SND_CWND);
>>   		tp->snd_cwnd_clamp = val;
>>   		WRITE_ONCE(tp->snd_ssthresh, val);
>>   		break;
> 
> [Severity: Medium]
> The commit message says the patch will "cap the metric and BPF paths
> that set it or set cwnd directly". Does that also cover struct_ops
> congestion control programs?
> 
> bpf_tcp_ca_btf_struct_access() in net/ipv4/bpf_tcp_ca.c only checks
> that the store stays inside the field:
> 
> 	case offsetof(struct tcp_sock, snd_cwnd):
> 		end = offsetofend(struct tcp_sock, snd_cwnd);
> 		break;
> 	...
> 	case offsetof(struct tcp_sock, snd_ssthresh):
> 		end = offsetofend(struct tcp_sock, snd_ssthresh);
> 		break;
> 
> So a BPF CC can still store any u32 into snd_cwnd and snd_ssthresh.
> Those stores skip both snd_cwnd_clamp and TCP_MAX_SND_CWND.
> 
> The native functions named in the commit message are exported as kfuncs
> to BPF_PROG_TYPE_STRUCT_OPS: cubictcp_recalc_ssthresh(),
> cubictcp_cong_avoid() and dctcp_ssthresh(). Take snd_cwnd = 1 << 24 and
> the default dctcp_alpha of 1024. In dctcp_ssthresh(), cwnd * dctcp_alpha
> wraps to 0 and ssthresh == cwnd, which is the failure the commit message
> describes.
> 
> tcp_reinit_congestion_control() doesn't reset snd_cwnd either. Switching
> from a BPF CC to native CUBIC, DCTCP or BIC would carry an oversized
> cwnd into their ->ssthresh() handlers.
> 
> There is a worse case in bictcp_update(). With the default beta_scale of
> 15 and snd_cwnd = 0x88888889, cwnd * 15 wraps to 7, so delta is 0:
> 
> 		delta = (cwnd * scale) >> 3;
> 		while (ca->ack_cnt > delta) {
> 			ca->ack_cnt -= delta;
> 			ca->tcp_cwnd++;
> 		}
> 
> Can this loop spin forever? A struct_ops CC could reach it by writing
> snd_cwnd and setting snd_ssthresh = 1. It would then call the
> cubictcp_cong_avoid() kfunc with acked >= 1 while the flow is cwnd
> limited. The CPU would then spin in native code during ACK processing,
> where the verifier's loop limits do not apply.
> 
> Loading a struct_ops program needs CAP_BPF plus CAP_PERFMON, or a
> delegated BPF token. A cwnd of 0 can also reach the kfunc hang, and an
> upper cap would not fix that.
> 
> Should the bound also be enforced on the struct_ops write path, or in
> these kfuncs?
This items looks like a separate thing deserving a separate fix.

/P

