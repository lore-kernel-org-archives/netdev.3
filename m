Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EDED44A3E2
	for <netdev@vger.kernel.org>; Wed,  9 Sep 2026 09:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788944551; cv=none; b=BQR4Iy/7duBCyzH4GuSkErfz+K4q4bx/2Tq7cSERZRgy58EpP+4PQNi5qSVryPdAMyxSXSXO/kYBp3A/sHraMWTTwm88YK2/j4el95RlX/VvCXvHxPFQzdGrHsCVGU04gqc9gshkl8sjZhD6g/W8j87Naa4p7m/BkWOnLQw7w5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788944551; c=relaxed/simple;
	bh=g4U2E9hZUa8sF4LfZXxzRRbrWXZNGS1KzuO2/2Xlgcs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X8uhS4pxyrPhN1TUK4X/heSsr093SSC618OR2WSyTB/SVWqn7sbPtZl9lqPxvSnt+v0LjsDvNboLb/R2k/EJSLloEffH328KtQTlox9mlaD42WzRNbSPVQ/X0iQ0SbTqlPP+FXtJVszaMJAjEYhoYUfETL5K284PQSVS5DS0i4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aUX3/JUk; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=n3VV9aOJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aUX3/JUk";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="n3VV9aOJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788944549;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pVoXZ4NPxwDjL0daQ21jdxg27zbYG0m6UPECpXtbd30=;
	b=aUX3/JUksnPm+RDUxa4wR/PUX9vUynMUIli95RJELeH/6ussxiBAoB26dIvr55C37RBKfW
	RMyb9GTQkEaeWMrevY5oGUU5bn9rgLo4ghyW8Qp9JG2ucJkBWCJApWaxAxU2459KN/y+YL
	jJapLyk20SHQtjZhPb7ttPfkI8fhWAs=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-522-IIHXHpREMuSraoNQycjqLA-1; Wed, 09 Sep 2026 05:02:27 -0400
X-MC-Unique: IIHXHpREMuSraoNQycjqLA-1
X-Mimecast-MFC-AGG-ID: IIHXHpREMuSraoNQycjqLA_1788944547
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-4858f06e142so3059143f8f.0
        for <netdev@vger.kernel.org>; Wed, 09 Sep 2026 02:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788944546; x=1789549346; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pVoXZ4NPxwDjL0daQ21jdxg27zbYG0m6UPECpXtbd30=;
        b=n3VV9aOJvgBic7JjsK9DeKCPhC0Llyinnfv3lNUfZYJE8HscRDZGHXXiw+SAawjYFa
         KAbU5ugdL/T731aiYCnnsQQlihhccjW8PfdvCYXr67kaJ9X73sDb65WpRXcXgAujEIIY
         7EI8Dd6AllDJBWBBqqk0TNaQeYdqGLdJBuAHOhqzwmL4Rpghs2V8ARQni28Y4Kh2E44j
         bQ7dOVbLr6gxWU5ufB+TGVz6WMGizeK+Vq78XxOnGSwP4b7ee1fpI8Qmq5SMeGbrp3do
         BT0NSMmzFlviXAgKAzJLYPKnp5Z6ip13PqdGRsf8dq/hDIX++ZnXaQDZ8l+82bP2bixK
         ejdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788944546; x=1789549346;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pVoXZ4NPxwDjL0daQ21jdxg27zbYG0m6UPECpXtbd30=;
        b=TFFswiHAwDLhCuGSI9LrAcXFH5crHkhEoeqh0b6LXpg+YzvRxNIbv9ROXDwpZuMZQJ
         NRpb20Ns9Kzz4b9Cdf2gk3VOYOAJde4aiLQ3ja6YU6BDezXTyY7vDKi6wrfaKjP8lpOb
         2jf39+vYpsmcJ/Y3asqdhyTq0VUP3/aQ35A/P8fI413NFEd7c3kwxUbgZznpJzeO/mZT
         uzXgNVz7TOAU2Rk0Zl0NkT6aJNxLGllxsP8Q8ZVH0P7+UVYuBCUAmAl1ddygP32LoUqs
         bxuRcfR0tK93MrlI6sjRFRoLkVIHvcMBysrfaM0lmi0mwDoEPgzFyb20RmJbk5HP82Ha
         2d3g==
X-Gm-Message-State: AFuF++nRkB5G6ruzfFCkMGwOB4VBI9W0bC/1MLxl73znZscdyvVvfefX
	A8FIZISeZUGzR3oJbusS7Vt+IDd06HdpgIua5lk8YySw6pKUZwHygixDYGGBwObGLUU6hsU4kgC
	+V6SCythiKQC6AoPz1vpOHMUUVRj5sqDKPvu0UxkIsr8KUkIBHwG7ZUF5P5ggETgV1Q==
X-Gm-Gg: AYBFou0u+NPK33XQrJamPHvNyJEpykagaDRJ9KBVyaFL9mKQiRqsIgoBcNZ3UCqzfaT
	oxxypMndHg+fqU3dR4+MNZ3MvLMierOKGqSN/UTtklXilMqWily1nxnuaomMTFFMZXqTclx6YpL
	VpHtgwASQJMJaIyoNZk6dj1HFA+USsSrJJStUZ34I/tq8M1nR+SnOLGh7AUb29CcZw3+amfnNwh
	Zy9XmX4unWiQL3mPz5dBhjNv3TMQYw8/FpO9JlqaNgII8edS/P5vzd/yI2mYplEa9Eb5yunGODY
	Ig03AQBbliLyiJVFpOixdoqSvzmncieP2nBhUugoaHyGMNlewROfQB83S/tFjGDVIsr9rtHqPGS
	yrn1jK7yEPfmucXUV6fA8sWBXsBXQQb73sNyoAwSQdPodolnsRX48LHmotgHNabiO+85DT/GByg
	==
X-Received: by 2002:a05:6000:290b:b0:485:8f9c:2875 with SMTP id ffacd0b85a97d-485ba5ae7a1mr55765f8f.12.1788944546451;
        Wed, 09 Sep 2026 02:02:26 -0700 (PDT)
X-Received: by 2002:a05:6000:290b:b0:485:8f9c:2875 with SMTP id ffacd0b85a97d-485ba5ae7a1mr55711f8f.12.1788944546003;
        Wed, 09 Sep 2026 02:02:26 -0700 (PDT)
Received: from [192.168.188.218] (ip232-47-231-195.pool-bba.aruba.it. [195.231.47.232])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485883acd33sm42211696f8f.18.2026.09.09.02.02.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Sep 2026 02:02:25 -0700 (PDT)
Message-ID: <c64ea248-6c91-4ce9-aacc-b9128dc08b4c@redhat.com>
Date: Wed, 9 Sep 2026 11:02:24 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] udp_tunnel: avoid calling the wrong GRO handler
To: =?UTF-8?B?SsOpcsOpbXkgSmVhbg==?= <Jeremy.Jean@oss.cyber.gouv.fr>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260906211351.1272699-2-Jeremy.Jean@oss.cyber.gouv.fr>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260906211351.1272699-2-Jeremy.Jean@oss.cyber.gouv.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/6/26 11:13 PM, Jérémy Jean wrote:
> setup_udp_tunnel_sock() installs the GRO handlers before updating the
> global static call. The socket is already bound, so packets can arrive
> while the static call still points to the handler for another tunnel
> type. Receive and completion can then parse the packet differently,
> leading to OOB write.

Interesting. A stack trace would be useful. As pointed out by sashiko
the issue is very likely reachable even without the static call.

I wild guess sort of full GRO flush is required before installing or
removing a tunnel, regardless the static call infra.
> Removing the static call is enough since the existing fallback already
> calls the handler selected during setup through call_gro_receive_sk().
> The helper also performs the same recursion check and sets the flush
> flag when the limit is reached.
> 
> Fixes: 5d7f5b2f6b93 ("udp_tunnel: use static call for GRO hooks when possible")
> Assisted-by: Codex:gpt-6

Even this one is interesting; this patch left out things that I supposed
much older model should catch easily.

Also please see commit 816d9992d9ed434ec52cfbd63080d518e535a41b

/P

