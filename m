Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com [209.85.218.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16BDB2853FD
	for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 07:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776322819; cv=none; b=Xrr246joApoGOo2R6uVbEjJqdghv+akKzxTBRVgl60QqQ41c/zC18q/DJE6yFcjHZ+NDZEIywn9dFbQhz1+419c1DGO0tqAlKa4T6fa0/sUqE3bFyEh9+vFKXnFhxkH7NPyvKG7p7Do/pL+4aF2JundAY/Ezuu5UW93G/rDoP3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776322819; c=relaxed/simple;
	bh=1d/45ztQbmb1tddj/Txk7c7+2hRXQ21v+FIJ30BVviY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=loUJueDrydrEvQaVAJeVQ8EMtsbD+MDxSafZRMzF2hWE/vpsPa99k+IzMK3zqtDTLvUB43A3+CIPhxKq+sU8lGTvFnwzwKRIIbVrIoUXzeymL6o278JZNZUHE4AfBF5CUTQIjsuyurmAgn10wSOIl84pC8hVNyVj1MIlyJm/cJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NRciOd/v; arc=none smtp.client-ip=209.85.218.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NRciOd/v"
Received: by mail-ej1-f74.google.com with SMTP id a640c23a62f3a-b934e96af9dso726331466b.3
        for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 00:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776322816; x=1776927616; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pDfoz5QhZtsVKhV4YzF8qvos4cyHNlbu5hYSeiBZxOk=;
        b=NRciOd/vSnb9Pe+oKcUVcjNq+XbgZJmgfbeMTbrnRnp7o6eK1HYD6oYKlU2o26thLm
         httnpDLEOD25snntJHGcDsaMfUUIfyhMhi4JBjyfCd1fj8crLa3oSkWIa98yq4l9hSoB
         7IwSjz6gC8cG0Qn8GDkME6DS6N0lKIrukNOThOE9Tvbq0fin26zmHCjHkivl9JwRR/LT
         1NRIZnmVh3+YGzVHU8zGeV+7T5l07Q4bZ60jaUGDPCspEVhIOcXTRgwOOll2/pRipnWj
         4XmIS5VbWKtlWBr0AlVsDsZvHEoSDMW2fqSp3+ztkROAB6ouKGUO7ak61Zw0SFFqgQe0
         y1iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776322816; x=1776927616;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pDfoz5QhZtsVKhV4YzF8qvos4cyHNlbu5hYSeiBZxOk=;
        b=lbCa5VBQ/RrFG7Ta4du/BSU1WYj2WfxQSgyVcJ25uvN9QT1nPX3MPK5l6xs+KlgIwr
         wOLUkgcw8BW8OACp+anT/v27a0I7wmZu4VOi83vYaFGCrIGI1nzc20bjxCCwMaxNDYto
         i+93uUZ1wFdlYVWLteoG0l9ZN9wtRZem2kvNSQAqOsotMqSFR45XiI5jVPSll+NfPsOU
         gQEY/fdLgTqi4FiVLd6SKsAy1RiqR4koqVu4f7o0QVym+DrYVmfSAPpl/i1kgu1TciqV
         zv3+4Mf4Dk0ADP+blNyrkkdQw8i1PuL9k6mjJpsdP8NSwohHHwtUtEkB23Lku5JXfO4o
         TgHA==
X-Forwarded-Encrypted: i=1; AFNElJ/2pOnLn47bUljX/mNTmaUxPr5k2+KtQEeM4aXMoWbJHCmdYFgU3taN7G7MEhGUcoYhLmk3Jns=@vger.kernel.org
X-Gm-Message-State: AOJu0YzT6ec/mEoqd5VMPxG5y8yF48Yvwsba++izFUzv16GqclEnadZS
	NJAmMdujZ2ipVxUd9QlsXcqRwKdZUANAHuOgmF6J0qA1nraVB6+RS1n3E1CTTGxD3vM6dY5hKRr
	qeN1F9gvfraMqhMBWMQ==
X-Received: from ejcqk43.prod.google.com ([2002:a17:907:7fab:b0:b9d:88f5:ae32])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:78c:b0:b9c:8499:e949 with SMTP id a640c23a62f3a-b9d7265cf5bmr1478918366b.27.1776322815979;
 Thu, 16 Apr 2026 00:00:15 -0700 (PDT)
Date: Thu, 16 Apr 2026 07:00:14 +0000
In-Reply-To: <96fff93c-c7ae-4480-8e0e-9f72c02a7b34@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260415-binder-netlink-v3-0-84be9ba63ee2@google.com>
 <20260415-binder-netlink-v3-4-84be9ba63ee2@google.com> <96fff93c-c7ae-4480-8e0e-9f72c02a7b34@lunn.ch>
Message-ID: <aeCI_iiOmpIdHDme@google.com>
Subject: Re: [PATCH v3 4/4] rust_binder: report netlink transactions
From: Alice Ryhl <aliceryhl@google.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Donald Hunter <donald.hunter@gmail.com>, 
	Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Arve =?utf-8?B?SGrDuG5uZXbDpWc=?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, 
	Christian Brauner <brauner@kernel.org>, Carlos Llamas <cmllamas@google.com>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Thu, Apr 16, 2026 at 02:46:18AM +0200, Andrew Lunn wrote:
> On Wed, Apr 15, 2026 at 09:37:54AM +0000, Alice Ryhl wrote:
> > From: Carlos Llamas <cmllamas@google.com>
> > 
> > The Android Binder driver supports a netlink API that reports
> > transaction *failures* to a userapce daemon. This allows devices to
> 
> userspace ?

Good catch, thanks.

Alice
