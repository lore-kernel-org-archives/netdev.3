Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 514D6399003
	for <netdev@vger.kernel.org>; Wed,  5 Aug 2026 17:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785952632; cv=pass; b=JkENx1chKaH6oFiTDFQbLl15KB6F9x4hTCuMDx73raIPk06LSTUeGYBZILZBH+ZiAQifDO68Nkn3gQ8KsqdzZ0m6PhyCADjcUGUINr7SaeluQN299+98J5vIboWxEnSyAMsejGGdNwIbiw+xzsdktbXqU0PHrT6Sxtf7VH8VJqw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785952632; c=relaxed/simple;
	bh=1O1MxAdS2HfcTbAQI4KJc5gaDXpcM9rbDVv55Dld/dk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kn+iLjsYyho3fIT+TtkXb7p5WHIckdh296Ksjri5irRY/MyDq3G4/9cv3MUzEFf3UlRMQ6NuZdk3+l5cVLX58UsMB2y/QRaX6Sf5A2PbTPNHIPhppp6JPFbVKaB5Z4m3anGh5odCkjsHyl0C0NH9Z8Nj71BQUsx/7fwiiepQ/yo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=O5hVccCV; arc=pass smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O5hVccCV"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-498012a61f6so5675e9.0
        for <netdev@vger.kernel.org>; Wed, 05 Aug 2026 10:57:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785952630; cv=none;
        d=google.com; s=arc-20260327;
        b=aatvCqDeSVrFSKZhZO7TzNejhynbL9JhuMMP0D/XNQi4V/ohSY+eGU0Yru1I0+TNXx
         JEFHz3D87qhqjyFftkQOh2ukOl7q9YWfi0woOUAsG//f6RrZXgbuJY6VkT9AgD6Ar9+B
         rQGM6s2lF4F6tG15M/sGl6jmPoI9oxJ05Q8/7ohdG9qnGBWsO4UAt/xqVfvwsBk4ZbuZ
         2AllYB8v/W2Gut/XtA1OhB0MIPrYb4d2du8N0JdW8WGjTBwtPjVr4ubbE+Jw6R/Xengb
         YZ2JyPpGQLzOO9NJ6lQQt7z9MFXihfOYFJBpV7FOZ0o56Eqpiob4L/xizivX448S/w/n
         v7Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1O1MxAdS2HfcTbAQI4KJc5gaDXpcM9rbDVv55Dld/dk=;
        fh=klnnOY0YXYGDmCWYD7jJRtG8y0UZBT2CK/3Q4cBqSM8=;
        b=JOrToDYbW6/eB+ikJcV92iJaZrcayFv8gMvRYkNCCPpuNL+xECbbdYD+mj4k+OCnvs
         TCZaiTRPW7bnhyQHcxXORcoutPA1ftiGvMduzoO4ufwHndG9TyMQKwhAMbfT/s6GfUl/
         cJoNUO5hJzQ4+EWNRuQgHNimkid/jaV5xjUymNWQ1yHg2c0mmcZr6lKO0cuZvkJN14fo
         PRO7+equkh+F2CvF6tUsAw3oFZpljmZ1z53uknIhIijeYgJLznciB+IWpnOw1ktm1ssf
         SFwZyGDt2mGxEIEmKJIrVvQciGBhMkXLfKFU8eWPQMlYU9tKnEqtjOE//bDPnseZbSnG
         ow+A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785952629; x=1786557429; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1O1MxAdS2HfcTbAQI4KJc5gaDXpcM9rbDVv55Dld/dk=;
        b=O5hVccCVg0yBfDWMoLHl8uaZU5LAhVxlgHy1r6N/BMmJHfnst1vNcZ2U1iCXB8HLIc
         IIJNRnndVV3wZS448UURnifhevh484D/sEyNqRCZgZI9tWFwnk/2zdaCjs6ACxjnhiPr
         nntnU+QBVQVxvXRIWQpIfyeiBLjtLd50P+lYaxzliwoFsG0VK1VXqXNfS+x1sZ5hr/Z2
         LEDU9T0lvrNaAP5qTk/ee37aVVJXslVpZ5FykAs5jFDTeT+H6aANT2q6zqQqGr+bYYXa
         OJqS0CyAL81SWa+w00rrpnAGdOmDaDckqNZ+BuPA1I02JC63cWEgqRcfFvjvUWsAGcXe
         owhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785952629; x=1786557429;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1O1MxAdS2HfcTbAQI4KJc5gaDXpcM9rbDVv55Dld/dk=;
        b=s6xbV9mtSoQh2dqnjUaL7km6IPfW5AbA2gRk3cX4CL3W1fCrRygnjTld96xKJvGjtX
         CR0uZj1TPRU8cqfXecwtdXqCSy8IMDy4aGrTqwfGgB8aAOLYzIBgS15qAQJ1ljnsBAqy
         rZEEbSSZAsmBDtD89X+/8OyaBZ8Ub01byb5YG39bv64iGQFAz/cWCUKwTBHG+j5ShFBm
         g/P/t8Ct3OxK0hxPj2nnzQ/w9cRwXQzifzYZH2XjDqu1NgeqIGkYPe4Udxy0zF9fadat
         WGAWCnrHrxARMQDkz4bFoHQz1xOBHNsc9UdW0T2D/yKXAVagfeKJvvB2js/I1EJBqMkY
         zgZA==
X-Gm-Message-State: AOJu0YxcJTqE7hpqxKCtf+p+2TkNRmCof9HKEpAohdLNN/QxZMjVMkSf
	iDnKJx4pSZzPKHrrLoUporIBGprbWnnYwHgk4IL/l8+qhJiWqQHYZT8E9GPtAsmIv8Z6sQVPXZC
	2SC53JD0Jo64b+MW8O/+r6Ox+51ghctncxqtpcWEh
X-Gm-Gg: AR+sD12X9NDpz4saPbreNE5Wn4MVuU7G/iBRNWkl3cBbGfuzdc1O5DUm+1irLHH1lhk
	S9thqCx/wVVIj3rY+3w0b5y1mcH9XjOGOmscXUSUNYABqo+ZVR9OoLl9mj2bFm5LSsSJe9LbrE7
	Kn133TK2XpWW/qBcauPvyBBxOuzxjgtPVr/aQgfCl12MZQcTQRJMIfL4CT0Vs66a5bEoZh+ELkv
	SC4l3xPIBZEloPhiVoQ7whPsWoIpIWQ9L2m1jPVdZhkUOUORL5chkx3Z95Em3wyWRBIPaBxS2xy
	fgm8NHE9BWovJJIYzAo/Z+IZDUQzcsHe4FMXgCAsYYCadq66cWcXCHGbjTURIBd4M3znkvrxcU3
	jBv/LdNafIPL5Io69frZXI7m/lQgZPds=
X-Received: by 2002:a05:600c:45d3:b0:48a:623c:8859 with SMTP id
 5b1f17b1804b1-49953c4a315mr26955e9.7.1785952629103; Wed, 05 Aug 2026 10:57:09
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260801131220.1367229-1-almasrymina@google.com>
 <20260801131220.1367229-2-almasrymina@google.com> <CABdmKX3Qyeho7Ru8HOzWyCrKXp=kf2H1pOUTXVR3tRWpYhKpTw@mail.gmail.com>
 <CAHS8izP_mxA=QxP-17cg09uF1Gc1if=jog1pM_imMKQ7Obj3qg@mail.gmail.com>
In-Reply-To: <CAHS8izP_mxA=QxP-17cg09uF1Gc1if=jog1pM_imMKQ7Obj3qg@mail.gmail.com>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Wed, 5 Aug 2026 10:56:56 -0700
X-Gm-Features: AUfX_mzt4MmWUgJ2L0T0dH-fUopMCnM-fsdVWZtRDKSd1cM8lkR4p5iBFPpUHXU
Message-ID: <CABdmKX1NvtwOevjq0G5v41WtqZKORTwi6G-7dbLHNjhjgfgGNw@mail.gmail.com>
Subject: Re: [PATCH net-next v1 2/2] selftests: drv-net: ncdevmem: gracefully
 retry bind()
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Bobby Eshleman <bobbyeshleman@meta.com>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 5, 2026 at 10:36=E2=80=AFAM Mina Almasry <almasrymina@google.co=
m> wrote:
>
> On Tue, Aug 4, 2026 at 12:21=E2=80=AFPM T.J. Mercier <tjmercier@google.co=
m> wrote:
> > > In testing environments, binding to the port can transiently fail
> > > following a driver reset caused by the preceding queue configuration.
> > > The failing bind() is typically caused by DHCP/IPv6 DAD needing some
> > > time to resolve and assign the IP address back to the interface after
> > > the reset.
> >
> > With EADDRNOTAVAIL? Maybe loop only for that errno?
> >
>
> I did not check the actual error code returned. I could.
>
> But is it worth maintaining an exact list of error codes to retry on
> for this test code? It will be annoying for the next guy to discover
> another error code that legitimately requires waiting, and then we'd
> have to maintain a list of error codes to retry on. It would be worth
> going through the trouble for actual kernel code, but it feels like
> more trouble than it's worth for a test?

My thinking is it's also annoying to have to wait 10s for an error
condition that cannot be recovered from. I don't feel strongly.
