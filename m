Received: from mail-wr2-f35.google.com (mail-wr2-f35.google.com [74.125.225.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EDF439CCED
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 08:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.225.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790150963; cv=pass; b=q1BPitSKCclvtpJ6dmfEyDNdq0BA50yyP9J+ZOLuBx+WFNMi/vNZDkSmRWpkEppUAoL2ePY2QNRoTtx7Y+SIdLB/ZyirQGy6OLmAqfbYqpBpk8624I8HHDbGLNurccVlC2ro/ad+uNBfjUo4PJTzR+M8JjWewxphMZeUhCvOEag=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790150963; c=relaxed/simple;
	bh=dpP91akbaFzZC6rOdZLmE8fjblFHqBWnDu8zdizP00A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RkfjQFC0WPL7b7DeiovrgHfBc29tUey17UtgX5tz+m74M/Iaz8WxGLPlBlA+h+tGLnEBimjsoyD1xjW9MqXUdAPc2+7oklf6LMj5hg127Nm12ubQWf3Wi/mRXK24kseL6EV6MsQuQG8I3G6rLvaQn740p1755LH2yfq/LNXlVO4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DutcuQVC; arc=pass smtp.client-ip=74.125.225.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DutcuQVC"
Received: by mail-wr2-f35.google.com with SMTP id ffacd0b85a97d-4858bc96fabso550752f8f.3
        for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 01:09:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790150959; cv=none;
        d=google.com; s=arc-20260327;
        b=c5fgcYpGoKqLzOvA5tZOFN/pkF92Oy9aVZsBTu0T3Zm6YgGwS4q5S4u08ZwaVmjsQ1
         9xFG7aN/df+qbhofV8ClA4E4Cr67UhCR03Embj8a4AffZSpOWjnxIiHUoFQs9LI2vqeB
         2Nez7WA8kWMEDDdG9E/WlvrsRxE17T0ZmDySQZ1vZzJjscHAWJTbn3dztczunYi7zyni
         YsCs/f3WIN6x8pdRLJnsA4lHIEaI0ojkQSqvVmWW2w2m3ZdAaOsDT9B3jcHOTzzx1M0Q
         1DMnJiyn0JHm8I8xSJTUk1edInBZ/Xxutyd9Lr8xk/CMao+0bz3xvb5RAxgBfTGTL7fz
         t2eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dpP91akbaFzZC6rOdZLmE8fjblFHqBWnDu8zdizP00A=;
        fh=ALAW6/u3EiPVK52SVcbZxFRUR2LuIln8H29GjZFGmj8=;
        b=A3+nlpEfawq14sv+CaC494Nfjt5P8FtnXtHySzbRtyeK+HfQLZweyws+fBr92WAxS5
         7/jAKT5yneKUX4lVpXpKnvOOBkrqhyo4nunMbONsOxAoaACDu+Ibwfyows1mQCQEPfT8
         cxY2nCyb7qFkgEdnaN9cxMyO2M1qNv8po6Gc8/eYClwQ3wnNDXKFFDl4uxvZ3voJ5DvN
         vRwkH2h8GG1mXvCkGphWAzhuNlLmIq9Jw/vsU4miZruJmoqNcnLAlz716hBy9aIzvSoZ
         bzJwL+CAO5XQw06Czk11jme/c6j/3EqSARTUm5/hdh/vg7CSDlJyWNnJ9Gppp18jN9dI
         Qvjw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790150959; x=1790755759; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dpP91akbaFzZC6rOdZLmE8fjblFHqBWnDu8zdizP00A=;
        b=DutcuQVC/HAYeb+HTdhsoWnZc6MI4nLZzEAsHaQM4jgtTA0H+KZfMkn+d//5qIDp6p
         O7YqcHu14pTs6yWkaks9hNRnoFJSrno/LjB1h54g11UgaNxkCe0Lt6xhmageRX4TuLHz
         /qJY+LhC6TBoGiRKvLQbY0bEnIsFjzTZD4x0j9p7aPaCfUNcu5fB5bdN8wuzQCw2NHe2
         5S5+ckq4zszgtSr1UA87QXPRi6MsQtsZK3DM7V1/gKh5jh/ewq9G0CJoDVpd9wmacL3W
         0e+hofqiV+9fDhK62u2rjMugsGultpU0FM1DKqJnkz4C/5oxJj0L4NNmBLTkO4m4SjOj
         /jMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790150959; x=1790755759;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dpP91akbaFzZC6rOdZLmE8fjblFHqBWnDu8zdizP00A=;
        b=OXUK9KMPzFHEZYTxc1Tm5m53nB+iDhjRydIDot4t6BCi89k0oGvGINnICI6C50vURL
         bgLTqFiDXum4HRjZqYmhB+sVGFLMvpokyUI7oacx8AhXLaOVQNkIV7pOGjv/cYt+947r
         CuAzIi5St1HL8Daf4UlEbg8cPbfXF5FRs0m6ecA0bXcP/kfueApV9tApj0r9HN143FLs
         FhxlUUfXj0Nj/gH0xvCeDeFYDBRwRkDn+OGR8e6kwmvnwTQ1zz42NFicY0z1Zm0vBabv
         hPbQ9iQaAco6MXZlcbVxJj5a3xDeGj3Quo3liBi675r4eydhVeceGQcjL8zJJYHigKH0
         JQrA==
X-Forwarded-Encrypted: i=1; AKwUvBz0duRGF/+elcytmTW95EvQ/aVOLgihOMo5mJzWap5JrrsaFWAYJ9Qq4gUhoZbIHL7V6v7gwrw=@vger.kernel.org
X-Gm-Message-State: AFuF++msFuKV0LuM+RkNYgMwa7m/74QXrNZMxlzbFejagkY9K+slhLXs
	YqUFNfNrc5VfA+lDPTP8hKhxRol/BzAz0w147J2uweJcyghsoYymbKee0XkrSefa0oEev1Jk6HR
	EB3a5eVYPriBvEdaSH4Mg9DQgb6UlYCc5LJQcvTlY
X-Gm-Gg: AYBFou0gOkBQbR9v1zYLK8U9jv2sE8tvmc9oZvNcTrfyw7mY5lCTM5kLV7YrmjM7BQi
	8yI9mn+oaIFl//EcdWrEiYyXPbNCtDdz/5UQpKzPt2ya67JdBJ1W03q10JcOEMhu7hnPYtgAA29
	H0+et7553Yr9lcfv4qpueciThWODceKyMvHvBiLa3e5kAA0nAfZ8nciF1PKxUQtEkz26z7kaVk8
	edD3vYcUQUTAfR2LkgNLFQiw+wNSN1kD8AvRppRpdNAMcX2qhzVK0YnygLLlVf44LiUaDs62LSm
	3VXLk2G+6vgV4204N8NG2yIVk18qcswOLOxoDZ/TKQoZrIk3jvUn3S4c2RYEMh4vmZYsqywS5Xf
	5Ce/D3amfMGx9UECsEibA
X-Received: by 2002:a5d:6f06:0:b0:487:6ef:86b8 with SMTP id
 ffacd0b85a97d-4886709e09emr2505954f8f.49.1790150958679; Wed, 23 Sep 2026
 01:09:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260918100016.100988-1-sagartaunk@proton.me> <KZuCCqRjSSbylbLLVhoUD9-xyBpzD9jUB4vGC16N0_hIra8SNxFeh9lEJ6FIMYMgKqf41J_swYT_HVx3w13k0cSrYYkBljOF56suy3gpgAU=@proton.me>
 <164304b3-3324-45f1-8766-536767e7b9d7@redhat.com> <CAH5fLgjBC7o4wt0WPH6xEkQEkOvsjj0ymLq2xAGXoMwN-fZyBQ@mail.gmail.com>
 <_OvWoTp4DaMWPlCDpP6QCis3vmI9jsT_GeJVq8e-7S_FvY5zurx-iRSvWy-rPwHnRGVixK2i7E_QybBBgX4YZVrXfsFbm6IwjmHpBvkoBuM=@proton.me>
In-Reply-To: <_OvWoTp4DaMWPlCDpP6QCis3vmI9jsT_GeJVq8e-7S_FvY5zurx-iRSvWy-rPwHnRGVixK2i7E_QybBBgX4YZVrXfsFbm6IwjmHpBvkoBuM=@proton.me>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 23 Sep 2026 10:09:06 +0200
X-Gm-Features: AclHuK9QTi04eiS47c4EvijGQ9s3_RK43h6MRQ9Dlx9YnzrxaDKzZpju_IdOlPg
Message-ID: <CAH5fLgjr5p1XMNGwOzigTW+CxvQpfoH8no46RneTCLinem_WTw@mail.gmail.com>
Subject: Re: [PATCH net v3] rust: net: netlink: validate attribute length
 before casting to `c_int`
To: Sagar Taunk <sagartaunk@proton.me>
Cc: Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Tamir Duberstein <tamird@kernel.org>, 
	Alexandre Courbot <acourbot@nvidia.com>, =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
	Matthew Maurer <mmaurer@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 23, 2026 at 10:07=E2=80=AFAM Sagar Taunk <sagartaunk@proton.me>=
 wrote:
>
> Should I resend it after rebasing it or would this be fine as is ?

Please resend targeting 'net-next' instead of 'net' and resend with a
rebase. Thanks!

Also, please read the guidelines on top-posting:
https://docs.kernel.org/process/submitting-patches.html#use-trimmed-interle=
aved-replies-in-email-discussions

> -------- Original Message --------
> On Tuesday, 09/22/26 at 19:12 Alice Ryhl <aliceryhl@google.com> wrote:
> On Tue, Sep 22, 2026 at 3:36=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> w=
rote:
> >
> > On 9/22/26 04:31, Sagar Taunk wrote:
> > > Hello, are there any updates for this?
> > >
> > > Also, I wanted to ask is it fine if I keep fixing stuff pointed out b=
y sashiko for now ? (I.e pre-existing issues pointed out by it in other's p=
atches or should I ask the original authors of it first ?)
> > Does not apply cleanly to net. Since a repost is needed, you must
> > also avoid empty lines in the tag area (i.e. after the fixes tag).
> >
> > WRT sashiko-reported issues, beyond be aware of false-positives,
> > generally speaking net-next is the preferred target tree (i.e. no
> > or very limited impact, very old issue, etc...) with no fixes tag.
> >
> > Focusing on high stakes changes would be appreciated.
>
> From my perspective there's no issue in landing this through net-next
> instead of net, as it's not urgent.
>
> Alice
>
