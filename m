Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794583271;
	b=PXfvEYmHYqn5juzpq5J1QjYSbE24GmH+v9uwoF50zCkcY3KG3A/xpe4UxwV3W3fGWzVw
	 kNYNAYBmifbmp2YSyLXHCPKdWIya44lLlmRbOFiY1qPCruDLfjSMtdYc8OvCOI478t5ua
	 Fqh/U58PzzXcF/wsyxRoDXdCq5btUwFobJa9tiydbhVG0xD6C6AcK86aaxxUuV3gpi7lD
	 YZqv9ItNmql09YTO83hZ8i0pRnDmZBzEiku3oUbO+sCLNbaPvI7kejVUZbLncffi0VzXX
	 RP/S8bUEcZBwfneBPyKyvyD6DIMG8QPsGkXY0d+WFlkNl6kdGvp2a6tiRwD0e4Msujg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794583271;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=OjIDt+f/7+dWlNv53r9qvEutgjmi1ked15ytPMp8nBU=;
	b=pRyFRGFrAbj3gBpjV45X2XJEBAcKHHBfNFDaCORR2WwzLsR8tmvht6+4tsKCotHhBV83
	 OfZ4S+ZyqbuliHpYUFwrYBKiyTtzBSZFhc4f2iz15c0wQrdrQoIyhKBrtm7kP8OY8Jhqw
	 fKgwfYLA+XVE/zQI03I6Q8Xw4To77GcSDrIRUxlQ60yNQXy2Puma3PuA8r3wvl+ZA/8kw
	 yy7yQt9jQpC+IuvQHWZJrCwJuqjV4EBpEeZQzvoRRJ58DpZwDz8hs7efOaB0p8qWjnAxH
	 UbAhDUqvlGiVUyhB6brBduutFx/Ax7DmH+T/r8hzukUVxiHAg4fKJ8qLN0yJ7aBr1pw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=debian.org;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=74.125.224.50
Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D67C606A327
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 15:21:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5D67C606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-67be4686827so1012301d50.2
        for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 07:21:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794583270; x=1795188070;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OjIDt+f/7+dWlNv53r9qvEutgjmi1ked15ytPMp8nBU=;
        b=PvUv9o+92m7ngWQtGDW3kzKC3Tij0IrpJ6hIGLnGI0j5aotLI3nI04x5oeaN1QBCjz
         AFTiZp1tw5RPvD+s5RFJLjToBhJQMPMA3npg1hRavIAa+ygxQxgyohxb7Rk8XNsbp5lG
         CGQpUGqZ+2iuglkMCmsSdDqRnnxaOCx/ZYCcC9lYiCUTnPwPFmFci9ugTMPBko/PVfVc
         bUjErn/v8BShifMCLygooARKF2z+IR/wO1CgC+3snHoq4nA+IKJuq/Cd4FY5bZ2P49hU
         CHTw0RBg4DTJwH8fQw+KlPbJLExKOmn9wvIieQQiNnD/bG+HVd+Jio3gq8WV2GtrYBs4
         B3yQ==
X-Forwarded-Encrypted: i=1; AL+hErEQ7SyCIM3vB0Fj16z7IJZDfUVGX2EwnIW9TJXEhJLpTG0PhyMfnNFk/3sGfG569qjMJvwVQ7I=@vger.kernel.org
X-Gm-Message-State: APuU4Z+0bl6DthK9JfnxIwlqYSG0EASeGOminR48qDzJDadT+J3fWF81
	8ItJYQZrXVuqktzim16+Pto5WbbowM2AWgyjiiFTSxh1hes0AikQOE3V
X-Gm-Gg: AYBFou1CSwi4F4fisKVnQ3afU9y0ocM/G72xE103S3x0frV8i7vm3aDOgMAeeoXTw/V
	meynVMoO4H2YmblqZaqICPKR1rWzABnmWbgIjOSa1prLtWY6axiQPVWRsD4rKRS0yt93A9jcTQT
	1hlkmnK6sGmjoTLQ64m5ATkGoh5sOc4J9VKDyjIaqlW8JC9oeXWAvPWymBIwPsujasp6ca2OU6A
	NamrmBD7LF48Q+qowjnRoPe7TS0iIl0/vlcfI5LlslhQ7fxZyugzwanNH9ebbNDvrQrGCgV4UK/
	A5M9UDaLKQcN/7tjad+/zFLvxJFuxCB3nG3vttUhAE6kUFInpBwrQhDeOxKON+AAlFrGzw+NX22
	rVzg0CPGv+UG/LNkhmLHoEWS8/O4TsRiPFv016E6sNP/g1MZKmlFD1lPRLVDvcjpiSfjlMRC5sf
	3ttFLs9pwVOueaAt/Hvef2DsKPK9Ngms4W6/3E517AfdWS4FZ2uQtOjJsZ4En/b0+W905OPQIWe
	1M0BX8JeylYRrlioRij+lRYHIW75BnaBJ6AT1GUj3f8DFZG3AlZeRK7FFzZ3XjHYAXYYZ0lOEG2
	Tr6dThxfDY8C3sh/iKXd
X-Received: by 2002:a05:690e:4503:10b0:67c:2b34:319c with SMTP id 956f58d0204a3-67d897f540dmr1252728d50.78.1794583270342;
        Fri, 13 Nov 2026 07:21:10 -0800 (PST)
Received: from gmail.com ([2a03:2880:24ff:4e::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67d8a629a2dsm2307745d50.21.2026.11.13.07.21.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 07:21:07 -0800 (PST)
Date: Fri, 13 Nov 2026 07:21:06 -0800
From: Breno Leitao <leitao@debian.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Karl Mehltretter <kmehltretter@gmail.com>, netdev@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Stephen Hemminger <stephen@networkplumber.org>, Arend van Spriel <arend.vanspriel@broadcom.com>, 
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH net v2 1/2] netpoll: use a raw lock for the deferred
 transmit queue
Message-ID: <avcqBLwy_TB0w6PF@gmail.com>
References: <20260928064239.32456-1-kmehltretter@gmail.com>
 <20260930192103.62973-2-kmehltretter@gmail.com>
 <20261001074819.gQ3w8q6P@linutronix.de>
 <ar7sTVun7mF-4nl6@gmail.com>
 <20261009155225.6Uy7b0wd@linutronix.de>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261009155225.6Uy7b0wd@linutronix.de>

Hello Sebastian,

On Fri, Oct 09, 2026 at 05:52:25PM +0200, Sebastian Andrzej Siewior wrote:
> I would suggest to untangle that local-irq-disable assumption. Then we
> end up with the ::write_atomic callback on PREEMPT_RT which will raise
> warnings. But those will appear only on panic() and as the last console
> due to CON_NBCON_ATOMIC_UNSAFE so everything will go according to the
> plan.
> On !RT the whole __netpoll_send_skb() will be with disabled interrupts
> due to the console lock. On RT it won't and I don't know if anything
> down the call chain assumes that.

Thanks for the patch, On PREEMPT_RT, the send path is clean.
all the selftest I have are passing fine, without a single splat, while
the unpatched kernel produces about a dozen over the same tests. 

On !RT, the first message triggers, but it doesn't seem a big deal.

  WARNING: kernel/softirq.c:453 at __local_bh_enable_ip+0x118/0x120, CPU#4: pr/netcons_netc/307
  ...
  Call trace:
   __local_bh_enable_ip+0x118/0x120 (P)
   netpoll_send_skb+0x1a8/0x364
   send_udp+0x348/0x4a8
   netconsole_write+0x16c/0x628
   nbcon_emit_next_record+0x150/0x3cc
   nbcon_emit_one+0x74/0x158
   nbcon_kthread_func+0x18c/0x258
   kthread+0x108/0x134

Anyway, is this patch something you are planning to send officially?

Thanks,
--breno
