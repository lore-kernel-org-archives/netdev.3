Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794464114;
	b=M9iTKcT0Y4mR/xzx4ZED0nwVRGsTY6i7KLNuwWhbIWMF2wa+mM/gzoXy6AklLqnL1Xh/
	 PHCm1W1fmktWBpD5QaXxrefKPl1N7v4hoj6nn1BrJHnlK3x041JFHkTPe7y6edJDFaV3Z
	 DKzFfJgJ9WTlAs8uRcW2TqXqN/KdcBSzJPqJaRON0pytgDJOlK8MnDQ0eJRjZ24LB1kXB
	 zrUDAdPjj/E/Jd+up5WGO499A+FhTOAwtk94URrMzXDI4rI1nJnVhTtdmRGvZLN1xwsr2
	 0rRfdUeRpY0bbe1HfLToJ2jd1nBJ+c5QJdHAf/fXrxuyA7gNKFDbDicQRk9nQuEmpRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794464114;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=Vx8jegixfG8ud0k0rnqc4fDDdtC8/64S6FMHMTINRGs=;
	b=hdl7MYI3VGADnka/QRRpEUf/ScOsc4MUYQ7jwqV08+ws87EIzR+rnNSQMI1T+R3+biMp
	 LgDR+c/8M7JG6eA41MDLw2fuAl19IBGTvq0r/u1adwe5kU05Y4d/wfWgyiQT/scG0XglG
	 L7Xw3izbC9ZEogIBoRop1X9QgndV02gtL+bXVWH7QB0ie6KCpWBVG9cg0xLTzfYqfLrYI
	 B+1TlzCtFbf+HWWJYokHTDGW6oPFTkNrE0VzJrPunECYV6+rVXuYEbkwzCMoboNw2mllw
	 ziIAk7QzwUaFYTAhlTk7zYzAQKh1EkoR7i531pL+3vTXxU9Lu1Z/m1zufUbh0+HejTw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=DfBtHZiA;
	arc=none smtp.remote-ip=209.85.215.198
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A4CB606A893
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 06:15:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9A4CB606A893
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=DfBtHZiA
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cdb869327e7so3466693a12.0
        for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 22:15:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794464113; x=1795068913; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Vx8jegixfG8ud0k0rnqc4fDDdtC8/64S6FMHMTINRGs=;
        b=DfBtHZiADm8aC1tIo3EBpHmPHMVbr7D6BjdBoK2VJBrjXXlJu/3NFxui5H1d6DCWUw
         De2QHLNcIqLLTOnXxnkpXkprRoegjS8s+jb8K8ih1VwQnl/3AYLhR7Un2oKQnWvUvPF5
         f2ChaFGA/RIIarWf+k44PrAyM6EesC0A3rFNoy/JValIylnNdCBggZUA01b4ejL7h3To
         aNw3p+RaefqN9eHJ7UJKD/wpR6IuBR/NyQS00D/90dLg3W3jhIc+Vf8vezS46xHvrHlX
         fEEV1Ew9K3rkG9ZooGMxEAFRGww8gOHmr35RKNw6qSuJDjwHprjV5iPx8x/zP5EKTXmR
         L9yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794464113; x=1795068913;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Vx8jegixfG8ud0k0rnqc4fDDdtC8/64S6FMHMTINRGs=;
        b=HJFgIWGbjJX6r6PT2hlBKAkVTviAGXGA3Ps2GNnz6l3oY3pMLLcw4mmHlpsJdrtsQL
         Wt2emvKpjWbQNzUHKpwCU/wN05dYOj/2dt0f0+Cf+W56KlmPP4KFWFgEzN0TzQsnda9/
         HRIyycdoBUNiwdSA/jpYbkjhMHaMhIIl6B3uqUriPoZlU1Lz2o6crutzFSPp7aMooJ11
         2d7yicYlY+QMAXxlMNC4FmgX2xZxRxlIXOYoceVaMk191TV9cyICR4ENdYeofPju28zL
         NWb2G7W6FiQ6kjDz5cGpCfBXofTjbokrR1i5E+fqSJDR+tnAj99jaQNqaY7EapY2J9St
         5J2w==
X-Gm-Message-State: APuU4Z+yjTM6U3dtBHNSNZgoCQKoLbtUy3BPqERWru1eDK07vsZKrh/b
	+RWSlMueaOSh11O7HxVeWreIMmiWUEqRiyRt1wxieJUDgwGscXutsLO4Hiy+eq6q6am68F3nkW/
	mME0EMg==
X-Received: from pjbee14.prod.google.com ([2002:a17:90a:fc4e:b0:3ae:c243:313b])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2245:b0:3b0:ab34:afc8
 with SMTP id 98e67ed59e1d1-3b182e94123mr4304859a91.20.1794464112721; Wed, 11
 Nov 2026 22:15:12 -0800 (PST)
Date: Thu, 12 Nov 2026 06:15:12 +0000
In-Reply-To: <340d9f1f96e235642e8b47b5e7c836a18de8dd56.1794325665.git.x-professor@outlook.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <cover.1794325665.git.x-professor@outlook.com> <340d9f1f96e235642e8b47b5e7c836a18de8dd56.1794325665.git.x-professor@outlook.com>
Message-ID: <avVX-3s3AYwtxQe7@google.com>
Subject: Re: [PATCH net 1/2] tcp: avoid wrapping Fast Open blackhole timeout
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Yingjie Wang <x-professor@outlook.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "mptcp@lists.linux.dev" <mptcp@lists.linux.dev>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "edumazet@kernel.org" <edumazet@kernel.org>, 
	"ncardwell@google.com" <ncardwell@google.com>, "davem@davemloft.net" <davem@davemloft.net>, 
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, 
	"horms@kernel.org" <horms@kernel.org>, "matttbe@kernel.org" <matttbe@kernel.org>, 
	"martineau@kernel.org" <martineau@kernel.org>, "geliang@kernel.org" <geliang@kernel.org>, 
	"ycheng@google.com" <ycheng@google.com>, "weiwan@google.com" <weiwan@google.com>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"

On Tue, 10 Nov 2026 15:47:58 +0000, Yingjie Wang wrote:
> tcp_fastopen_active_should_disable() calculates the active-disable
> interval as multiplier * tfo_bh_timeout * HZ. Since all operands are
> 32-bit, a large tcp_fastopen_blackhole_timeout_sec can wrap the delay
> even on 64-bit kernels and re-enable active Fast Open too soon.
> 
> For example, with HZ=1000, a timeout of 6912213 seconds and the maximum

No one wants to configure 80 days blackhole timeout.

Please apply a sane limit in proc_tfo_blackhole_detect_timeout().

---
pw-bot: cr


> multiplier of 64 should produce 442381632000 jiffies, but the current
> calculation truncates it to 512 jiffies.
> 
> This issue was found using a static analysis tool. A loopback reproducer
> induced 12 Fast Open blackholes and waited 1.2 seconds before opening
> another connection. The unpatched kernel retried active Fast Open, while
> the patched kernel kept Fast Open disabled and used a regular TCP
> handshake. The reproducer required neither kernel modifications nor
> fault injection.
> 
> Compute the interval in u64 and cap it at MAX_JIFFY_OFFSET before adding
> it to the saved timestamp. This preserves the existing exponential
> backoff for representable intervals and prevents large values from
> wrapping into short timeouts.
> 
> Fixes: cf1ef3f0719b ("net/tcp_fastopen: Disable active side TFO in certain scenarios")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yingjie Wang <x-professor@outlook.com>
> ---
>  net/ipv4/tcp_fastopen.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/net/ipv4/tcp_fastopen.c b/net/ipv4/tcp_fastopen.c
> index 7f7eb3cc1c04..aeefd605414f 100644
> --- a/net/ipv4/tcp_fastopen.c
> +++ b/net/ipv4/tcp_fastopen.c
> @@ -613,6 +613,7 @@ bool tcp_fastopen_active_should_disable(struct sock *sk)
>  	unsigned long timeout;
>  	int tfo_da_times;
>  	int multiplier;
> +	u64 delay;
>  
>  	if (!tfo_bh_timeout)
>  		return false;
> @@ -626,10 +627,11 @@ bool tcp_fastopen_active_should_disable(struct sock *sk)
>  
>  	/* Limit timeout to max: 2^6 * initial timeout */
>  	multiplier = 1 << min(tfo_da_times - 1, 6);
> +	delay = (u64)multiplier * tfo_bh_timeout * HZ;
>  
>  	/* Paired with the WRITE_ONCE() in tcp_fastopen_active_disable(). */
>  	timeout = READ_ONCE(sock_net(sk)->ipv4.tfo_active_disable_stamp) +
> -		  multiplier * tfo_bh_timeout * HZ;
> +		  min(delay, MAX_JIFFY_OFFSET);
>  	if (time_before(jiffies, timeout))
>  		return true;
>  
> -- 
> 2.43.0
> 
