Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793645361;
	b=a3/xmCPgr3e1B4jNi6Qk+Stq0SYwW4NJ0JzuqY77l23XPHuSWptXKQgcBuA+K8kK0tXi
	 SggUgpeTzuNjnbXnt8/VqVEHiE2wGB/WBRdOZzAr7sZqIzxjlNHniXF3NSDArJITbp9iE
	 OSrcngN26LYnIMicuH3Hx3BHvs6RUNYCwLJasphRKCzjEhDu0oa7ix9itZledR2IEvJgH
	 eb+cs9GwG0DF0UYnxG39zZe6uwoDcUTt8tqvU2W6rCq11vFJo2yW8oc3wVPyQr6lHjQel
	 HqkEhoLxJfge4lGvd6Vxm1tQneRMXMrJ5lVMmd8/uoSkPmzVjo/ixCk5zN2N+MFO5hQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793645361;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:User-Agent:References:In-Reply-To:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	bh=4vMJyvF9u6Lpo0n/jndkN841uR7BcIWd5sMOX8N/aKQ=;
	b=Kdx6KgdhLUTNfu4wl2c7+NkEqBKxN9oPcHtDbxpIg/EkS0PvqcGss9O4PLixUTvd7lya
	 W8CiygmD32IaOsb2/N9+6liJCqIzj0+yE68hOlIP8yba5qEDt7f/2+uHoX3XFVQ6OQitm
	 n1W9OYT97rma69PrRlcfKy+quLUfx9Uav2mv8ZRBG75GgU7dy4cGbDKQNeHs+41zA2+Ey
	 okngl6UE9+L0h6NNAF1ylG6o+i9SwJ0FT2ALQ/uuFjMvDg0FE0KalvXr7GQGVOha7WjqS
	 VN0epcYEgD9PLwq7jFlSj5y4CR4pCEjEXdt09kH6RK6ERAeax+jqNFStWvwxj6fCARw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Pg9NFYks;
	arc=none smtp.remote-ip=209.85.215.174
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C09606A327
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 18:49:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B6C09606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Pg9NFYks
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-cd61cef87f1so1323267a12.0
        for <netdev@vger.kernel.org>; Mon, 02 Nov 2026 10:49:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793645360; x=1794250160; darn=vger.kernel.org;
        h=content-type:content-transfer-encoding:mime-version:message-id
         :in-reply-to:references:user-agent:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=4vMJyvF9u6Lpo0n/jndkN841uR7BcIWd5sMOX8N/aKQ=;
        b=Pg9NFYks9gpgqRc8umdDXJ22OFO9Biy/EaNROHoasLmA1XWaVcs4eflGnUPlpeQnit
         TiR1n5GDgsexOLkUozfAYC8rvCoGwAEKvTnvYXNmaFKUnPcSoxD6nwe6MhyE9ybFnz33
         TY4vfoY/cDjygnKMnZwVNj82PsqqHBYoRjgXeGXGqLs/vaGxG2v9Cnves+LnlhQJMBae
         3whtZO73djtKfp/SzHRlw3umBVoFbtIi80uDclaWTouc1dt0bwP3c/u7DxMMrai9/jBj
         H1JmobJ7pF4M2qkmbm4Pj/QS7ljScOb3sVgR8aCQt/DG/T236kn6R+GdoOFY4nBQ5WGx
         ReIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793645360; x=1794250160;
        h=content-type:content-transfer-encoding:mime-version:message-id
         :in-reply-to:references:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4vMJyvF9u6Lpo0n/jndkN841uR7BcIWd5sMOX8N/aKQ=;
        b=XC5pRyTna49T02Eoh1PyUnVVvaOGH1S723Qy1bV+vRvjd22JlJsE3xelcZqgUkHyL9
         q/N1m6g/uWatKbMmRYwatudBfHRjrcZA/TvF26daeohkOkZGKqZddkoLtV8Sd5qbyOCS
         kVwuTASVfQ35lhiwXRHlZdlhfO5Ph89j1WRDHBWk+/hNbbGCZXZ5x7LdWGBp837e2+2q
         +k0VuAfuJGiIl2shwOHN7v51GkpLaitjL61u689z4hV5jn29V5qAacDdjHfSpAG7KZXo
         aF9+HGDPt8ocONv8abCq/ERpbSRm51wYmEV+VK13ASFS1cWlxOCau4yrsGRQxm6iPG0A
         2xwQ==
X-Forwarded-Encrypted: i=1; AKwUvBzwoEXXpU1mfrkDGX13cuErPt2bbnBfzWQZAUbCWb/22Fk9bWuQzKh0UOK1Kl/SOVw6QfF3d9E=@vger.kernel.org
X-Gm-Message-State: APuU4Z9QOKK5H1qTN1v9urof9mbW9QJSwTZE/nguwNi/Wg4NWVeema1x
	d1T4sFF8D7yonpCrmZbe3P9rdfZrw9p74GmUeHHrQsVO5KexCVpgbJEX
X-Gm-Gg: AYBFou2WO9ewiWqwWfl3Uy+wr/UhtzTFdIeEATnK7BwKjNkP0QC8KKvTWVNKX/a08yh
	WMQgj7jXRS4fRP1lFrnCDgNDpACReEl6PefDX4it3D4e49yCwx/nuRfoMtJjCZrSYCJQeYQ8k5w
	1HMCp7touTZLOMxEpB6ysd9/tegiYANwx+vfb+E2o15J5sDV30i1s9fScwwQUXCOmfgHy5EWn92
	1538Q2lONKUxjXEbUGPnTWErt+1YxDPZc7jVnswbEr7g27UfgssLBAGIZq0R25+KondJ4aftN9l
	yEZ9my9heudP+w4Yc2yg5nfn71e/zlQ2gZWzqnpsA5UWJ0gvO8lG30Uj20mA7zGiiULxeizl2wo
	czpvk5jlePuU3GV+HhnR3OM5lbjOSL2DK6j/Q6Chv3/w7TENWn7m7PNl3zyawy4wFn3R1awH+mn
	5hp2YSvy4DwD7eeWSWuOlJQdLxD8x2QZKLjXBWqd+MvxNRvv0U+OCZcxl4K95KqgI6GFXsp/x6x
	83eZTr52ojaJkKIVBCwC7jpB9mwkvbHI3rIg9NcwktWq1fXZfzX5J7FE+FG828XeKe3kUVZjuty
	6WdxDksQz3hCLNwTBiw0si/qn8wBPcDkZ6l0piR0jkGsrrFZ5HJfj+YlYDDEZZtbwD3U
X-Received: by 2002:a17:90b:48c6:b0:3a8:6045:5a24 with SMTP id 98e67ed59e1d1-3ae897e0e39mr7985674a91.38.1793645359949;
        Mon, 02 Nov 2026 10:49:19 -0800 (PST)
Received: from meli-email.org ([98.97.42.147])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b07c6271ccsm431541a91.7.2026.11.02.10.49.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 10:49:19 -0800 (PST)
Date: Mon, 02 Nov 2026 11:47:50 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: mptcp@lists.linux.dev, Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org
Cc: daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com, john.fastabend@gmail.com, jakub@cloudflare.com, jiayuan.chen@linux.dev, davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, kuniyu@google.com, willemb@google.com, matttbe@kernel.org, mptcp@lists.linux.dev, mason@kernel.org, josef@toxicpanda.com
Subject: Re: [PATCH bpf v2 02/15] bpf, sockmap: Don't let an SK_DROP verdict stick
User-Agent: meli/0.9.0
References: <20261102072112.4160195-1-alexei.starovoitov@gmail.com> <20261102072112.4160195-3-alexei.starovoitov@gmail.com>
In-Reply-To: <20261102072112.4160195-3-alexei.starovoitov@gmail.com>
Message-ID: <tnw1m6.2g2esuogz4hv6@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"

On Mon, 02 Nov 2026 00:20, Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
>From: Josef Bacik <josef@toxicpanda.com>
>
>The verdict of an sk_msg prog is valid for one message, or for the bytes
>that bpf_msg_apply_bytes() requests. These bytes can come from many
>sendmsg() calls. Thus tcp_bpf_send_verdict() keeps the verdict in
>psock->eval and runs the prog only when psock->eval is __SK_NONE. The code
>that resets psock->eval is after the switch statement, but the __SK_DROP
>branch returns before that code. Then sendmsg() drops all subsequent
>messages with -EACCES and does not run the prog.
>
>Reset psock->eval when apply_bytes is 0, as the __SK_REDIRECT branch does.

So no one has tried to do apply_bytes + DROP I guess. If you want after
this series is merged I can add some test.

Thanks.

Reviewed-by: John Fastabend <john.fastabend@gmail.com>

>
>Fixes: 4f738adba30a ("bpf: create tcp_bpf_ulp allowing BPF to monitor socket TX/RX data")
>Signed-off-by: Josef Bacik <josef@toxicpanda.com>
>Signed-off-by: Alexei Starovoitov <ast@kernel.org>
>---
> net/ipv4/tcp_bpf.c | 3 +++
> 1 file changed, 3 insertions(+)
>
>diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
>index 8cf63a9e7fed..d90bcc911b36 100644
>--- a/net/ipv4/tcp_bpf.c
>+++ b/net/ipv4/tcp_bpf.c
>@@ -509,6 +509,9 @@ static int tcp_bpf_send_verdict(struct sock *sk, struct sk_psock *psock,
> 	default:
> 		sk_msg_free(sk, msg);
> 		sk_msg_apply_bytes(psock, tosend);
>+		/* The verdict holds for apply_bytes, not for ever */
>+		if (!psock->apply_bytes)
>+			psock->eval = __SK_NONE;
> 		*copied -= (tosend + delta);
> 		return -EACCES;
> 	}
>-- 
>2.55.0
