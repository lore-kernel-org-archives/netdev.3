Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD853909A6
	for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 16:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786552425; cv=pass; b=ZGpImtZvfTGQqRd8jig7MW2fIpb3ARBzJ3YNws1WopIBr5cRoaeW9cNfVg1/YlR+Za8XMPQ/+75hUvSLv661AfuLsCu3l8kdj1nS0rF9vO9T2nAH9z0PSnIB6M3tAvunP644qsS3dWzmK5EYiBOWJPG6cjrlWiyEecJG/hfVcww=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786552425; c=relaxed/simple;
	bh=gOIsyGGYeGZsd7+1t35VENt6hUZ6tCz5k0UwrPgrJB8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NVvvWg/retkM3IxYkuAO9E2shsz8keQn9rD8V2x1H6Dm8ztmWcqqcSxT30JfLJ07K3h86abyTBmWogCdPFqkFU5qupqPH/Bo1fW6+qSVU6NTjytC9ah+6ukIMwQ4zXCxHGQK0XUjp0Rsu6INwZADMtbMUwJcRbpFKx2eMzKRamU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Al5TqyfU; arc=pass smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Al5TqyfU"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2ccae46de39so2130125ad.3
        for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 09:33:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786552423; cv=none;
        d=google.com; s=arc-20260327;
        b=APe1250alW64UgXpysHGWlKLXvLOFrL4pyIsszvnHLrnf1nhAUq4vnJSJZMjiTMfkg
         AWG3SR2XD00iU+p/bU2IJBCFKC4GriKDkELZtjli8cekMWaK0s3CeaPKZ+fHTDcspfF4
         UgZBMrjh4Et9UeLm7/hpwKSzWwtkoJkPlZgm9GWRTehTBuk6IG7I8kP8G2kGmRXOOCgl
         srAzV7pA2nEgVCEC9rie+aGk61seVzYSfSYjCKZC9nEMWKL6BJca1VnKxbP86Hquto1D
         hwLzFHO1M2AVlUEkL9HHzLDy8TKHpE/LraSWme59LArefCUh9OBEun4LrCcFPC048x1d
         pePQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=D4SZ6u0V1SghQBdqtC98mKtc1SLMxMH5ah0RWt1B7vw=;
        fh=8m4yzc9Ea8YtATtR4ldQUsnUZEIL7jiSoglUI38N3sY=;
        b=r8CeM1Dt31QaqiH1VM1izfDXX7CfykZVYUbwrbWfhKrPb20rqdoVQbKkZUdYCb1RJe
         wj7p0zhET7bUUshpGKtTBH4GD9qT2/q/sULzAD1+TWGwmLo14Hkv88cnGUCY9W5AE3RG
         P0XoxnWExe1GqUZD/8BOta1+89NwX/PQfvX7lyoT+UE7vOgOOGej4lMVfoTi6vMllouS
         Ue2IsPLkgivg7C/AdnjQabqM1245nFrW48tFPq4vMkKQs0HyxNNJWpUnebh9TvRUwplD
         Pc5RFHssb6CyDSLf7GjSolqae7QH5bOdRjiL39cPx4Onl3CpHs16H1i9+waOS2xFIurH
         oSFg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786552423; x=1787157223; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=D4SZ6u0V1SghQBdqtC98mKtc1SLMxMH5ah0RWt1B7vw=;
        b=Al5TqyfUu+23OQeZiYehEwCKw9h7n1GWuwvFfs5W/FN6ixV7O12veg3o/+6+ecIG5q
         gi77Jv50TJJVfBr5tK78wp8gBVgj+5Y7A46NSJQiMg9vf/b+171Ld/CV/ytLNCLuYUX5
         JGnwl6csWpus6UXO9bC2cOxNn79Q6o54bdsEtVRm7+6yYsLP6x21sneKJH7rILfD6V6Q
         tMWciyTleAT2pJLtlHf4Ke1yqhLx3FZDQ5GOYVRZdJPiPy5U/KlYo5NBcXMa/AeygtYc
         /sE48ZwkvJJt8DLXaboqm3a/tld2DEUcqAqzzQ8WWBf/PsfhZ7ZNON80nFOWRsL+Ksc3
         WL8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786552423; x=1787157223;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=D4SZ6u0V1SghQBdqtC98mKtc1SLMxMH5ah0RWt1B7vw=;
        b=U5YdxJv14vDwbKirBijLhNfPa49HCUMgx7SMnSOClXk03ezwvyd58/bhE+PbGiZXmw
         EVLaYf9nfiKfRFyg2E9aFjiIxsx1hIXIQHPtR+5baIjg+YMfSR227RTDfM5bqdgx9DPo
         vNJS/Hdp4q+foVOhEC7vHO/GWBG7VQGuxjhIk/AGcNIzGdmRN28bhQ3QIYb9b7PCxix/
         Ooxh8F9OI0Mo6RAcYd1FW/L9cvR4AOAVjNn8HpimRrTSEXWJD8WVB+DPlXy1CdERrqzx
         3dnQ+Y0qD3PwLEUBbJ+Ii5Fw3UWRKXv9poqYqbc1Jw4Y9yPQvXqbOUOH71NbibruW7lx
         LGTg==
X-Forwarded-Encrypted: i=1; AHgh+Rp+iBgH9ZYmfPBKijK2L4gTU6QdGhU5SfEeZDusE9aMF5nzQdHkJuwrigqBdEih2GZJGCshVyg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWmnTZ58QF9Ci5Bk32FnBw8upB390YGDXUVQNUlz+7buY/U1es
	QAVvj3hhXhpdutunkF4JIpdo+JLcZx2EJXde12PU06dHZl27s0tnxMLSHlY1LOfzycpipH9ljUG
	8Wv1H0Lvvkk6evDDddpACKhEOeqOICZY=
X-Gm-Gg: AR+sD11dDplCSl4vV7W5bFEfF7VeJ+DY39ncu73nCad0nc3Nw374TxtHOIO0F93kY/B
	xb2+p9BRGZPKT7sDpH5GSU23aX5JZH07v3W8zDG8RB2kBE5kUUA+Ar6atu7679OmAZFiUO2G8jH
	X6QRPE2h8ISFIt8trAJhwtk8h+rmLbAtygKukO0VEm9T33JjOrqiVULX9QwxjtRM4DZF1Kkcxdb
	NXlZjjGPkjgsUGjhL4pGsy3U+5MebEZFMc2R03yHr/v0MoS/I17J/BLlVvDkVf2YVyOhelWRnGN
	xDIJSqsOvTEarDeQA7q3eeyZtUOEAD9kQeCeavxJziy8z+CL8y4x8uObBDkj+DDggtf6Bq60O6H
	nDSLOZ59MIZkbGIuBRn2LNjG1sF6RrWXp/OPGIQxFpJ+5g3sFVHzmXl6lPxps
X-Received: by 2002:a17:902:d552:b0:2cf:9e90:8be with SMTP id
 d9443c01a7336-2d3456e7622mr58880125ad.4.1786552423044; Wed, 12 Aug 2026
 09:33:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260811-fix-fops-owner-v10-0-7e71776f9dbe@linux.dev>
In-Reply-To: <20260811-fix-fops-owner-v10-0-7e71776f9dbe@linux.dev>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 12 Aug 2026 18:33:27 +0200
X-Gm-Features: AUfX_mzHM3XF1m8TGRbbbrVs79_o_CCgi7jI9gpogE6umN7ICq8ixcdhm-skrqA
Message-ID: <CANiq72=bhfofrbdf1qeA380-eWeKj5yXhC0NzaU_nbB9SpxYHA@mail.gmail.com>
Subject: Re: [PATCH v10 00/10] Fix missing fops.owner in Rust DRM/misc abstractions
To: Alvin Sun <alvin.sun@linux.dev>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
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

On Tue, Aug 11, 2026 at 8:41=E2=80=AFAM Alvin Sun <alvin.sun@linux.dev> wro=
te:
>
> The series moves `THIS_MODULE` into the `ModuleMetadata` as a const, thre=
ads it
> through `#[vtable]` to set `fops.owner` in DRM/miscdevice, and updates co=
nfigfs
> and rnull to use `this_module::<LocalModule>()`.

Applied to `rust-next` -- thanks everyone!

    [ Fixed `clippy::undocumented_unsafe_blocks` lint by wrapping with
      a block. Added interim `#[allow(dead_code)]`. - Miguel ]

    [ Fixed `rusttest` by adding a dummy `LocalModule`. Removed interim
      `#[allow(dead_code)]`. - Miguel ]

    [ Rebased to avoid the imports cleanup patch. - Miguel ]

    [ Removed Acked-by and Cc. - Miguel ]

By the way, I removed the Acked-by in that last patch since I think it
came from an older version as a series-tag that didn't have the patch.
Please let me know if I should re-add it.

And since I was editing that commit for that reason, I took the chance
to remove the Cc because Petr already gave the Acked-by which you
collected, so normally you don't need to keep both in that case.

I hope that clarifies! :)

Cheers,
Miguel
