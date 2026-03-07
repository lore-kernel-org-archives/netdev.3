Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2EC826D4F7
	for <netdev@vger.kernel.org>; Sat,  7 Mar 2026 21:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772918388; cv=none; b=CzFrrZvfthmOPAXYqWbP3ZTzqWGbrUuPbQkYJr7+aEkT0NJpFnU2/XVnvdr9l6WZDB/sNm8CHY8/G2Knx2zk/Opk3hiFtnVNf/vWkVUtJX6qHZdvpm0YZwMgCNRpmyi+W5KrmEo6lQvEej/pWzkMeybQmtY7l+tmNA0VXcl5Oqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772918388; c=relaxed/simple;
	bh=EyEhd8isLT2A1zxJ3MYPyibZR68tS1ElsUONBQssKnU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VCJ+ONWnhxakGLa5WpuWju+N7hNQlbUdwNtC7L+UE4tJHx1Pi4N4XRQ37MK/j6zj+J3DYzwFobXynmaVY+XlN6f1DLIh3tVTQXzoVg5A44HLB6iAMWR20HbucqkoSrPbXyY+Xqhg4vTreLY0qlreNSR4ZbLynJaigEp6ESPmrIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QnMDcQrh; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QnMDcQrh"
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-439cbc5fd75so3056346f8f.0
        for <netdev@vger.kernel.org>; Sat, 07 Mar 2026 13:19:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772918385; x=1773523185; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lTCrtPJ7PlQ0PfecVrHBCkWSm+F944hA0c41XfadJYw=;
        b=QnMDcQrhMJF0650BvaoP36mNfAyAh1P6KcIHm8HQqlwBuPkPuaNiCOv1URgduKT0Le
         8rw0HLaWZfB/BSJemKM2556dJ/1/X8BqT2UWZXnq4ny+Dt4WUxFS6WYSbGlqdJlXw/NL
         dwVAIi7GbZwkN4+mUZg02eryZWz6jYa+Xq0wRQY72SVMGwhoyR4xJUUjt7kMU2k2OcMR
         CQ+5G8bs6zU88ZudMyZptDpnPb6/LKLxcYUzDB7D4v36PLYRhbRPPIZ02Gs72sRpoU+y
         GkK0aBWf0i3RepGaf0Uwc2Ro17wZPuC0bKYvQfBA116M9CQeavKShmqHRlpjEuiEd5bt
         wE6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772918385; x=1773523185;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lTCrtPJ7PlQ0PfecVrHBCkWSm+F944hA0c41XfadJYw=;
        b=LsBUdL/Cr+Rj5AqrAqF6zKJ5ur3Ne4GdcgBZz4XEFn2UuxO/W4MFn/gqq6oq76uMVP
         /TYIpQ2J3MNafyRubc5yBJHiXapp3/GkiBHQEVLBlmoXnfTPAD1WZld+aq9ePXMzU3on
         Ps7whSbDGmTLcypbVeb1hRIghUEGtodtmXMXOdhmScVuGgY4IsZpyEU6WgurhFhDzPon
         cS+C976WYihwul401edmAUdLW59sUUyTCNLiTLNJN/FtmNIgDGaq1+q34KTwwYhtSuPH
         9wotpScusqhLaX3wc4evUwKWqhuZSeGMUnG6ZpsyYUH4+xBHogvDrLKCnjtKb6JJFyOE
         EYmQ==
X-Forwarded-Encrypted: i=1; AJvYcCX4iELA5BY+o9TQRi/nIcIvqHQMvNvfHHz+6UZyJhxkuY2smr2wbVdT/bNCFJtnM9XA0nwwrO0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxM+v/KSoINBaCUrjNMJOdA/HZu4tgw+iWS73LjrsxZ5WBGstLE
	IKz0enmj9pqQ4A7Bl/cRQYaTUYyO56wOlgJ7NHYgqDaGv5XDJE2B5yHZ4d8OeqcjfU/AWQf0FBg
	Wl7b3X4oK3jkc9sxkGw==
X-Received: from wrbbn3.prod.google.com ([2002:a05:6000:603:b0:439:cbfc:f8bb])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:2482:b0:439:bae9:6151 with SMTP id ffacd0b85a97d-439da67bff5mr11365076f8f.48.1772918385124;
 Sat, 07 Mar 2026 13:19:45 -0800 (PST)
Date: Sat, 7 Mar 2026 21:19:44 +0000
In-Reply-To: <273a1167-2269-400c-931d-953063bcb733@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260306-binder-netlink-v1-0-daceb5bc83f2@google.com>
 <20260306-binder-netlink-v1-4-daceb5bc83f2@google.com> <273a1167-2269-400c-931d-953063bcb733@lunn.ch>
Message-ID: <aayWcASp31c5D7Pr@google.com>
Subject: Re: [PATCH 4/4] rust_binder: report netlink transactions
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

On Sat, Mar 07, 2026 at 05:56:45PM +0100, Andrew Lunn wrote:
> On Fri, Mar 06, 2026 at 03:12:16PM +0000, Alice Ryhl wrote:
> > From: Carlos Llamas <cmllamas@google.com>
> > 
> > The Android Binder driver supports a netlink API that reports
> > transaction *failures* to a userapce daemon. This allows devices to
> > monitor processes with many failed transactions so that it can e.g. kill
> > misbehaving apps.
> > 
> > One very important thing that this monitors is when many oneway messages
> > are sent to a frozen process, so there is special handling to ensure
> > this scenario is surfaced over netlink.
> > 
> > Signed-off-by: Carlos Llamas <cmllamas@google.com>
> 
> Hi Alice
> 
> Since you are submitting this it needs your Signed-off-by as well.

Oh I forgot to update this, thanks for reminding me!

Alice
