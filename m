Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45CF643E9C9
	for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 10:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786615460; cv=pass; b=uUYQ7g991zcvhp/VC0w95IzuOsafPCXMcIoaP8FalwFJKubroTNDFgi0NBs8wfP/vs2JtdKAayKYf/brIWeLaBgrf/2qWYegLyJCQUJZCEiGZVRLPsyUDF5E8433etS2PZcWOIcA7LdSCWEyPQ2VNaTChjPbSw2CIjPc7Ys9MPI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786615460; c=relaxed/simple;
	bh=izncAFina5udvh82qhiR9A/Ymo2QgJMmGzIkcJM+wME=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JPt/JDmOpuphN+WdZ5bULvCYWwAgrywjveQ/15n4mqr/efTmS6RoSggsZpOZtDkhxVHjOFYzzWQqx5eJD3hqN8zMW0zPicgqE1L6/l3fR6/vrA1ndW02N6wgw5ama0hzQhP7KLGugne6a7seEikluhcUaYPHjdNhKnW6unPJyPU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NFHTrXRV; arc=pass smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NFHTrXRV"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2cf49dc28ccso3654025ad.0
        for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 03:04:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786615457; cv=none;
        d=google.com; s=arc-20260327;
        b=NjKZVFUY2IQ8ZOJF22SA4yklEKTQ+itv9+0ZkQFW5ZVxfwRK+v7iGSYK6W5iQrI9Qu
         2EcD9XnpqlT4Db2/Uv7rfLBTH5dfcdO1WPuA5pioA4w2fKW+SkUbpQ2RRL+QVtKXSnnS
         rNPrLTYkKT1KibaHlzYFRvVpZuLxJGmlfewG/xwtsMd78nqI9gVNAgRMiDr+kcdkhonO
         TUSUfj5gjVOu3XMRjsYzYvmr/PAb/fAsrgpj/UTGGGHmbg/aonBVQRfE9gLS6DKlGJ0A
         E9VJ1Y1aWcVn91dyb+vPEroQgB2pPqbtrQt28LAhR485/4EKKegiYUCyF37WT6bdiBqE
         T0MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tMciaZ/JSlG6Z7DNQJEd4FD/fd9CJYl/s1BR40smNTE=;
        fh=hb07j90RU1AXYBuxdm9GchnX6qndwtkphXjZhrivCWc=;
        b=ll0CwTIIqFdareclGfixCN9tUABM5zeMTuRxTmEih2fR845ouvJqGrWheMcZqXi5yp
         sUlGOg74pNT4kVmNWdoyYHKIdtCQrOel5k0KgYsC9Zz+fBxTROuPIjo/eUjNqYS6wReS
         dnQrRdexfyq+h2kwG4wRSDWdFYPjym7+rv9es3XAteP49ZILZLRxlxYrPzRTQm6AYeVw
         zIfafIKEhK2L+NAWHC7dG0MUQx229NcdpkoeX2zfZWAePuBm+WbjqwbxbpO4ten9pyqY
         cyfXPDxFgrCRry85XANVl811Pqy6VJ7Fj1ypHRgvvjdwYhHbzjWrPZBHpujZJKtF7XF0
         DB2A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786615457; x=1787220257; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tMciaZ/JSlG6Z7DNQJEd4FD/fd9CJYl/s1BR40smNTE=;
        b=NFHTrXRVpZQTifaiiAeRhSGvfW/dP05MC4U1EuRQWVJr10hfFTND65+3+8jb93NkKj
         pyVgNvfrsAHjJCQSlBnv74kIuyAGwTSHOr/dBTUV0FlXohKVfuehKEUbu+Xe3QIPOuZT
         xyYOmMs01ckolTS4zDf1GolYHoz54YaFz1+Jivey5iRPUdra7EMw9Z/AYpSZUXI96EKd
         3/FfoMhZEcw+UBCPoCbiwXXB7S4RQ9x13SiLR20aVLYVohDLsUPCpyg8prA+dVsmLDAw
         h9GzD11ijNfTClaEZMVLRNH9dpACZ2webaPItG2U1BR+OiDQwMwbfXeiDxCLD+bWtAte
         hzcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786615457; x=1787220257;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tMciaZ/JSlG6Z7DNQJEd4FD/fd9CJYl/s1BR40smNTE=;
        b=jUO6jHVMBDJeYlXdvdxbSsxjsa3Q6g0V242TSI8relwK/pYLQxL2aUeGEqhjwQ5YdE
         jJpxxsIOeJjpvpyvBAQ+qJEj2o1suHM0WR/UqfIeScIFi1RO5w0Han9XLr1+UzB4LQuw
         wnOfuxE+fm07U3h50+dcVo4doLzfRdtJNbbbFyr+BLJyf5/zLEzp5axwT8LZ8iowWRIr
         5h+0S82pXfdsIieCTGyDKbUuf1QuOrCbn7MstAR/iYr15Ae7Dr3X1PM9o1rv2UpwdBGM
         9XEc29faVHGM/06FM30HK12fQOlBIU+e4dYSv5NQ6CEp6lKS/5twj6j94iUMOJMdHjFj
         WziA==
X-Forwarded-Encrypted: i=1; AHgh+Roc0vCo7mUUoTG4oYlzciEgFksl0jjXg0ZLZyj010sGOvUX6+PCo49f1cvh6ya+dIoFkTYHHc4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxP2qHezfriFitJAsC1Dq5FwV4hJJbJ1fPP7fXvFxpQ8UvXjKlq
	h3AJAWp9B+eUqKS4Jyicofd8MpQqu4TD/Q1xGDgDu/C/gnVF1/iMKE+6I+nQz9vSMcHvikDQZLN
	wQC8RbzgDlKPKLT7D1bA129yhosQ+0v4=
X-Gm-Gg: AR+sD10DrhQG1NmI/HnKXfxJP87DjktlU+qJ01UL55vHE73/CaPBCrvYhj3J61pX9LF
	QAZ9atWV53jy/VN4X7y7/9lLCGcvm6N6U/byUgX1LE9ADi2cAjAJp7YzNUWxC+joogBg1IUmbJC
	rSWOZMslDceD4zzLczu9nfOWNqUJhTMZ8HfFVLFObixcy3cY9UBZJHECp+JJmmD1VnIAEaPhzeI
	2hOopAoAUAy0wgS/0f3E215H86S8A+qU04BjLa56F8oQx2TiwzV+U+Bmkm7tYo1yOpFtJHzj8kq
	4bzFpToKzLMHCAU2vGK0b2aTdECGQPx8+IEaiWJRJ2IciFDWbXLTMHhVaOT55sKTbyLhK7EVNQ1
	6ZBRRsIS/0eN3t9ySe1iAyU7uvzjUbqnjkUOAxhCKLDv9jPmB1tZvLoRAJL2H
X-Received: by 2002:a17:903:19e6:b0:2cb:2b50:d9da with SMTP id
 d9443c01a7336-2d389b61bdemr35547795ad.3.1786615457444; Thu, 13 Aug 2026
 03:04:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260811-fix-fops-owner-v10-0-7e71776f9dbe@linux.dev>
 <CANiq72=bhfofrbdf1qeA380-eWeKj5yXhC0NzaU_nbB9SpxYHA@mail.gmail.com>
 <DKNAS52KYWLD.M15VEC6U0F6R@kernel.org> <DKNDF3WD27GM.5VP6RBRXZBUS@garyguo.net>
 <CANiq72=SP_nT7Z6NSH-GT51-8hJ8qLUa07Cs+SarSFTO9Z7vUw@mail.gmail.com>
In-Reply-To: <CANiq72=SP_nT7Z6NSH-GT51-8hJ8qLUa07Cs+SarSFTO9Z7vUw@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 13 Aug 2026 12:04:04 +0200
X-Gm-Features: AUfX_mxe0Lg9da-FioFXEgvJltaWUVJqtXi0b-R5y4sq5pbip1KqobICrYsDddk
Message-ID: <CANiq72=Whd+u0cA88++KyeOQQrsBK+NqK-586jNX7L=_Ocixrw@mail.gmail.com>
Subject: Re: [PATCH v10 00/10] Fix missing fops.owner in Rust DRM/misc abstractions
To: Gary Guo <gary@garyguo.net>
Cc: Danilo Krummrich <dakr@kernel.org>, Mark Brown <broonie@kernel.org>, Alvin Sun <alvin.sun@linux.dev>, 
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Aaron Tomlin <atomlin@atomlin.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Arnd Bergmann <arnd@arndb.de>, 
	Brendan Higgins <brendan.higgins@linux.dev>, David Gow <david@davidgow.net>, 
	Rae Moar <raemoar63@gmail.com>, Breno Leitao <leitao@debian.org>, Jens Axboe <axboe@kernel.dk>, 
	Dave Ertman <david.m.ertman@intel.com>, Leon Romanovsky <leon@kernel.org>, 
	Igor Korotin <igor.korotin@linux.dev>, FUJITA Tomonori <fujita.tomonori@gmail.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	=?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Christian Brauner <brauner@kernel.org>, 
	Carlos Llamas <cmllamas@google.com>, rust-for-linux@vger.kernel.org, 
	linux-modules@vger.kernel.org, driver-core@lists.linux.dev, 
	dri-devel@lists.freedesktop.org, nova-gpu@lists.linux.dev, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 13, 2026 at 11:32=E2=80=AFAM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> Ok, done -- Danilo, I took your diff and converted it into a proper
> commit, please double-check you are OK with the Signed-off-by:
>
>   ec6fcf8a175a ("rust: kernel: add `LocalModule` fallback for
> `#[vtable]` `impl`s")

We also need an `allow(dead_code)` until we actually use it
unconditionally: a2595ed13816 instead.

Cheers,
Miguel
