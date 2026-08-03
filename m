Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D853BAD9F
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 09:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785747626; cv=none; b=kapUbb5rVjs5k1vlQjooCaPueHJLCwcVqS/ZSjbhzMqB5b1jYUp4Z6E9jjQGqRHNRQ8jl173NgB+Kz+uLRR0hnvKpDSzeKgH19RI41uxPUD2e8x7CRj9kDmSIius787UXonN64eH02RKnulm0Z+ayeblvPipdXXzeYdVEaftjy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785747626; c=relaxed/simple;
	bh=0zlJd9Yr6UpKiQThq/l7IWb1Lcot2jQVu687ixt9vMs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XOBhTQEfWDiNFmhEzkotnszS3OSgFUuLIP4m3L47cplFiVRJTxvqLMi//n0lOleyfpV4VmOi5gW6LdIg1aj3M9uoZR5OxIHwoyxJmLVLMyGWKtSrInhMomZ9CHCM0JLGwHDG8vk78gmaN2i6BGSSOs4+oewgXuBBoUaOs6iYBCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=XW+D8Fvw; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="XW+D8Fvw"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-47f96c5b722so1800321f8f.0
        for <netdev@vger.kernel.org>; Mon, 03 Aug 2026 02:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1785747617; x=1786352417; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/MEAqomLnokyVR9AqA64rl9ZYCVmUcv5C80fBRfsQys=;
        b=XW+D8FvwjzgcjUDkSi+A0ELSC7rPA4P4Ejct47bLSvBqMC/dKAeDev+KeubJawbkIO
         YUIRwVBy8ZwXNlMQLOfjugsDUMJFyfFjXr6xDxx4qD8IwdBU8RLho57NNV0Ein9y7KFg
         CqwpaZuViPwTNglZCGKO5O30o03nWWAfDNi3WFF9coTY/hj0BGCC4ia3CFTnDrUnMbv5
         2lRJpiysPJoQRHepKyIHFwlgrZlqxzjuC/Z/YrxR3oJRNMad27PGC1x2NOl7rDe4zIr/
         3cGo0QNob2p2wmths/Y9UXh/yvOMBumGDQ3my3J/P5hqq6HS0NO/LjVccTtFmO9JPOSx
         X/BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785747617; x=1786352417;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/MEAqomLnokyVR9AqA64rl9ZYCVmUcv5C80fBRfsQys=;
        b=pX3nYMD8d6oru8gPZK2DSlVUDOnrg15Epa/RefUEGHG6o4oKneji99+GipWDT0GKSx
         9Ut5rGu+P2J9mEoLOhlKFCvo7wLMxdf7YHmo+Cyaz0Sv86RBR9aWx+R/LX8itgN85bUJ
         naEjoF1A9zFSOyWzvAf4J/BET5/p51Ro+/Ifq424uuCKQZOIJwiVnX40bBEttznojVgV
         U8+Y/fGZRhGhitqLZw4fupATbfySUSK0xcT6Pbm4VLMreURw7WkXAHKKMjETUyYWBCgg
         QA6IAy2zUYpU7LsY5Fs2/53ED4eQTyau3tVzEKGn9poqpFiNWHMVOnO3e0ojyhWcZzZ2
         EYhA==
X-Forwarded-Encrypted: i=1; AHgh+Rra9suQar2b7SB40TNaYpqUgT1bhiTpe/jDTGU6UN+nkqQE0AG95tCB6JJ0HXOkD4kjlEMH/mQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHQ7orYMSmfO/ObOv2VQ/dWyo0pbVNulTB0/nVRjy163qsLChg
	qZJy636UQu+WjG6++YrBbFGLXCP1ltmwh64eVJojDKKVNcLkXk/RNeT1LqdU//GWOWE=
X-Gm-Gg: AR+sD13Pzpc1LB5ovzGq27mwoRfVcri0O7GYONaZbVhKN5+ODZmF1ZmMoQB3Ndqrxy2
	mFVKgqpOnqO/ftNkLYl6GgBIezp9Ru8vmTLmWigxY3ye0IZs5U6DQxC9Rt3FjbL6sZclujcatuD
	RcXRwUtqLK0VIHBu6MRAfj2Da1VQ9u3xrNOyI9NEjgunNZ1w5MTyCfBs4ufPw2Jy87Gc7EL2wfp
	qH961oPQYtUGhEhXl3IN8JNaQvtAfDMLe34Ns8/k1wnlIqnufP7IquahB18TmONFUy9Ywpn2vA4
	vRxSd298HP3T6M/XGJ/Eb92yJuS5Gk/13WPFSCdHhIDd1ZBCAzBygdo2LZXe79k8DWNfikn/F1P
	LQu2QzU+BbwPrAWyIcZRIdFHCq5tn9ncfW/oV8D72tQe+GXuERE52SzPU4KPThOS9mDdpH19l+c
	0MU2ldSIsIvXpvIJO6S5WL99SP98e1D/8YCwA9HbpR2fEL/4ZFroake0aphNNIZzp0XDTZI1KhJ
	F+qu7A7/zP/HvUIEOt/Rc5dsfSvt7T+xkCCYSCx030ihDyauOQjbE+UJkEO3RIiJjWq7Ne4xv0f
	WisYfuSl7fO3MxDsAU/+k6ie9CGM9ldOc6LREEGRXw==
X-Received: by 2002:a05:600c:871a:b0:498:952:e276 with SMTP id 5b1f17b1804b1-4980c66c991mr237479075e9.8.1785747617287;
        Mon, 03 Aug 2026 02:00:17 -0700 (PDT)
Received: from ?IPV6:2a00:1028:838d:271e:8e3b:4aff:fe4c:a100? (dynamic-2a00-1028-838d-271e-8e3b-4aff-fe4c-a100.ipv6.o2.cz. [2a00:1028:838d:271e:8e3b:4aff:fe4c:a100])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49807ba13e9sm314596535e9.13.2026.08.03.02.00.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Aug 2026 02:00:16 -0700 (PDT)
Message-ID: <6e9e8189-e27b-4279-9fed-b7da5da62419@suse.com>
Date: Mon, 3 Aug 2026 11:00:14 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 02/10] rust: module: add `THIS_MODULE` const to
 `ModuleMetadata` trait
To: Alvin Sun <alvin.sun@linux.dev>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>,
 Luis Chamberlain <mcgrof@kernel.org>, Daniel Gomez <da.gomez@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Daniel Almeida <daniel.almeida@collabora.com>, Arnd Bergmann
 <arnd@arndb.de>, Brendan Higgins <brendan.higgins@linux.dev>,
 David Gow <david@davidgow.net>, Rae Moar <raemoar63@gmail.com>,
 Breno Leitao <leitao@debian.org>, Jens Axboe <axboe@kernel.dk>,
 Dave Ertman <david.m.ertman@intel.com>, Leon Romanovsky <leon@kernel.org>,
 Igor Korotin <igor.korotin@linux.dev>,
 FUJITA Tomonori <fujita.tomonori@gmail.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 =?UTF-8?Q?Arve_Hj=C3=B8nnev=C3=A5g?= <arve@android.com>,
 Todd Kjos <tkjos@android.com>, Christian Brauner <brauner@kernel.org>,
 Carlos Llamas <cmllamas@google.com>, rust-for-linux@vger.kernel.org,
 linux-modules@vger.kernel.org, driver-core@lists.linux.dev,
 dri-devel@lists.freedesktop.org, nova-gpu@lists.linux.dev,
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-pci@vger.kernel.org
References: <20260723-fix-fops-owner-v9-0-c1c3af7f7bcb@linux.dev>
 <20260723-fix-fops-owner-v9-2-c1c3af7f7bcb@linux.dev>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20260723-fix-fops-owner-v9-2-c1c3af7f7bcb@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/23/26 4:10 AM, Alvin Sun wrote:
> Since `const_refs_to_static` has been stable as of the MSRV bump, a
> `ThisModule` pointer can now be used in const contexts.
> 
> Add a `THIS_MODULE` const to the `ModuleMetadata` trait so that modules
> can provide their `ThisModule` pointer in const contexts such as static
> `file_operations`.
> 
> Add a `this_module()` helper to retrieve the `THIS_MODULE` pointer of a
> given module type, and update `__init` to use it instead of the
> `THIS_MODULE` static generated by the `module!` macro.
> 
> The `static THIS_MODULE` generated by the `module!` macro is retained
> for backwards compatibility with existing users and removed in a later
> patch once all references have been migrated.
> 
> Assisted-by: opencode:glm-5.2
> Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
> Reviewed-by: Gary Guo <gary@garyguo.net>
> Acked-by: Danilo Krummrich <dakr@kernel.org>
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Alvin Sun <alvin.sun@linux.dev>

Acked-by: Petr Pavlu <petr.pavlu@suse.com>

> ---
>  rust/kernel/module.rs |  9 +++++++++
>  rust/macros/module.rs | 18 +++++++++++++++++-
>  2 files changed, 26 insertions(+), 1 deletion(-)
> 
> diff --git a/rust/kernel/module.rs b/rust/kernel/module.rs
> index be242a82e86d2..d713705984477 100644
> --- a/rust/kernel/module.rs
> +++ b/rust/kernel/module.rs
> @@ -42,6 +42,15 @@ fn init(module: &'static ThisModule) -> impl pin_init::PinInit<Self, crate::erro
>  pub trait ModuleMetadata {
>      /// The name of the module as specified in the `module!` macro.
>      const NAME: &'static crate::str::CStr;
> +
> +    /// The module's `THIS_MODULE` pointer.
> +    const THIS_MODULE: ThisModule;
> +}
> +
> +/// Returns a reference to the `THIS_MODULE` of the given module type.
> +#[inline]
> +pub const fn this_module<M: ModuleMetadata>() -> &'static ThisModule {
> +    &M::THIS_MODULE
>  }
>  
>  /// Equivalent to `THIS_MODULE` in the C API.
> diff --git a/rust/macros/module.rs b/rust/macros/module.rs
> index 06c18e2075083..aa9a618d5d19e 100644
> --- a/rust/macros/module.rs
> +++ b/rust/macros/module.rs
> @@ -519,6 +519,22 @@ pub(crate) fn module(info: ModuleInfo) -> Result<TokenStream> {
>  
>          impl ::kernel::ModuleMetadata for #type_ {
>              const NAME: &'static ::kernel::str::CStr = #name_cstr;
> +
> +            #[cfg(MODULE)]
> +            const THIS_MODULE: ::kernel::ThisModule = {
> +                extern "C" {
> +                    static __this_module: ::kernel::types::Opaque<::kernel::bindings::module>;
> +                }
> +
> +                // SAFETY: `__this_module` is constructed by the kernel at load time
> +                // and lives until the module is unloaded.
> +                unsafe { ::kernel::ThisModule::from_ptr(__this_module.get()) }
> +            };
> +
> +            #[cfg(not(MODULE))]
> +            const THIS_MODULE: ::kernel::ThisModule = unsafe {
> +                ::kernel::ThisModule::from_ptr(::core::ptr::null_mut())
> +            };
>          }
>  
>          // Double nested modules, since then nobody can access the public items inside.
> @@ -616,7 +632,7 @@ pub extern "C" fn #ident_exit() {
>                  /// This function must only be called once.
>                  unsafe fn __init() -> ::kernel::ffi::c_int {
>                      let initer = <super::super::LocalModule as ::kernel::InPlaceModule>::init(
> -                        &super::super::THIS_MODULE
> +                        ::kernel::module::this_module::<super::super::LocalModule>()
>                      );
>                      // SAFETY: No data race, since `__MOD` can only be accessed by this module
>                      // and there only `__init` and `__exit` access it. These functions are only
> 

