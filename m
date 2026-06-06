Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 583303A4F4B
	for <netdev@vger.kernel.org>; Sat,  6 Jun 2026 15:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780760407; cv=none; b=rCn94oxcbosMhmWRvT72hLRG5jMYVK+vZ5uvBgk4O67dwXcwB2blIouB+HOxtlabKS0X1h9b4DOPlj8kGK3EBMwaSzKAIh9SPHasXOrCQdJrt9heWK598o9+EniQMZr9JtAtXvp3g0UVOW0VN/+k5tUQHZRKMm/A41J/j1MuqqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780760407; c=relaxed/simple;
	bh=AuKIwPE9i3X2sktlXsXGaLAwIb/BDdnSeCnhtqcogZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WuTucmra6zCB+CnJt9L7mtfkWq6ZLuvHuZwH6eg/z/1PJfsuAdyJUBD+yvdgSoQGAHI6Z4wJJErB2DI7t0VmkWo6X/8cybOfAUivlWjbk8zVRDdmsEh5VxFpg/EUTBSO7myLN1oV1PNxz5pDazxN52NQWxNzprGNySM3febYhbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CrhlwUWw; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CrhlwUWw"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2bf22c18ad3so223815ad.0
        for <netdev@vger.kernel.org>; Sat, 06 Jun 2026 08:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780760405; x=1781365205; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JwDie3vRqtcV2a97m5zHtuohN/s1ZYi4/aVuLdrFAXM=;
        b=CrhlwUWwukbPPkHXxZ0LcCIGfJSCd3U9gRXwItDaePd5QdDHmlCeVEWzfoFB373Eem
         Rfi+u3/Mua1D6hri/vbNU2yDMeQQ/y817ekAFhYH2CJpsh2+U7vn5nsyqC7g6AtbHuV2
         Q59e3UkzFhZL8sacctC0umz0qohB92/lHEk/aP+Bror7ZeZsMbkpL2TTHwPVxUb6oKIw
         3UT+vqnbrFwAkiu4Oiw0kinO2VEIDkqjCB9krnB/SvmvelHeKsZWmdwrhyMMruKXNo9o
         IIii9cbBqeiGXf0IBoVykut6dkBUiQylxVjcRyt8nF6yuIaGC+Q8VmzDUPBA0GH52b8E
         papA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780760405; x=1781365205;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JwDie3vRqtcV2a97m5zHtuohN/s1ZYi4/aVuLdrFAXM=;
        b=Hze/GZN7MFZr/9sz9o2UX6sr9438KWidFxbxJqm9SbOgDTw95yzipP99g1EHvxCdL/
         zgdg5ikjuU6rkgbX4WdOe9dX6bo1EBPd4ySP4zOlA3En9Fo0g1KIst2FQmQvjBiofebK
         AULW886PQQTT7h0FcvX6Und1K8OyC6bx3sEyV/M57K8or5C9R5ExU7+mPyUNgiQzETvN
         Y1Rz9Ft90YpcGgooTM8In/FBhlI41nKDCd0CBZ7CXpnicsiuGiPxLwDp8qC6yorHDwCp
         LkR9l68KQAgi7rVjKjvH6m56cMjQ4U/FqX3h4r+jHtSizHtnKJpXMvD5hxb+60pMaU1u
         hQGQ==
X-Forwarded-Encrypted: i=1; AFNElJ8d8TOmECfPm9sMy94nVBvK9KN5bxRlsnINU2U2Ksr118pbVPlkwBZKchz8kofoWkYtMdpEkpk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+8E7q3Xt2PA8BNU7CcpZQVzwlQWO21biMo0bJqWk0kDRnuFrN
	FNoYhSux5ss81JZKYRDifIrEGZhCghSA/VdH7cHQhv0ySFRLFpEh2cVTqqZvoIHWWA==
X-Gm-Gg: Acq92OG/mqHI4w4OldRtgdPIBeg01pBrkzTtQxQmCKTOSPsI5AvD62NuJqhRL6wv1cI
	evdz2eIr3s0jvBjK039KIQfzc4UZud7tUXI3AJgzHkdhRFnq5XARK0n/B4vpT3c+Xj/DrbJpDZX
	QQ+m+zJ1iaqTJEQG2gUKVp4Qx3LxGztbsev21QUZSxgktRQUGThUJA1TF06ClHpnTohthtQ2XIn
	R107VEGYetCrxUIyduN3+XqYUGpcXWX0Cxs4uaqWy98ozqPZtr9VAPkfBxMIqYNeR3SPqRxQGut
	LIsuaciIl4uEPCelreCnvMbwflJxduVZxW1SbUJQLCbZp7Ob6Aq6xGI/fb9vWzueyE4Zx7bJV1h
	g+KEgcLwewo0PkviSQA8Z+P1fz8Ut/yNINmPUh9oIkqEQQpb8zdEivk6PEmpsVKAaxh9q2IddGl
	xOA4F2e3j+BOHGcGTZrGvNCBN3bJPA7ykiXUnk5sDUlP8vfl9d5EWz8Nav07o6WfY5nd01fcE3w
	0l0fi3qemUcgSjvDn9imKYIxv8Z+Hnv1tFpjGUAC7bRbMju+YONq6pL
X-Received: by 2002:a17:902:e885:b0:2bd:7e8e:ad56 with SMTP id d9443c01a7336-2c1eafba702mr3201455ad.6.1780760405089;
        Sat, 06 Jun 2026 08:40:05 -0700 (PDT)
Received: from google.com (112.174.16.34.bc.googleusercontent.com. [34.16.174.112])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c16649d2d4sm118379915ad.77.2026.06.06.08.40.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jun 2026 08:40:04 -0700 (PDT)
Date: Sat, 6 Jun 2026 15:39:59 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Matthew Maurer <mmaurer@google.com>,
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH v6 2/3] rust: netlink: add raw netlink abstraction
Message-ID: <aiQ_T4g2mdHwcxmp@google.com>
References: <20260529-binder-netlink-v6-0-92dd74b6a32e@google.com>
 <20260529-binder-netlink-v6-2-92dd74b6a32e@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260529-binder-netlink-v6-2-92dd74b6a32e@google.com>

On Fri, May 29, 2026 at 01:28:39PM +0000, Alice Ryhl wrote:
> This implements a safe and relatively simple API over the netlink API,
> that allows you to add different attributes to a netlink message and
> broadcast it. As the first user of this API only makes use of broadcast,
> only broadcast messages are supported here.
> 
> This API is intended to be safe and to be easy to use in *generated*
> code. This is because netlink is generally used with yaml files that
> describe the underlying API, and the python generator outputs C code
> (or, soon, Rust code) that lets you use the API more easily. So for
> example, if there is a string field, the code generator will output a
> method that internall calls `put_string()` with the right attr type.
> 
> Reviewed-by: Matthew Maurer <mmaurer@google.com>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---

Reviewed-by: Carlos Llamas <cmllamas@google.com>
