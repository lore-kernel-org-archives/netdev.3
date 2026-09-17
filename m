Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C2814F4CE3
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 16:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789662216; cv=pass; b=EptLZFSWPACfQD7PTTuthknx0ziWLDY8m1nfId4Kez1tIvi+7Okvxcr2K5GEPK/OhtPePvFu/UmuqBGEl/Ws/ajoz3gPNv6Co5dYH/L51VwxfWpUUSn/ikoQ8Vy6H68qDJAkmzRAczTHgNkEm4ijchmgTs3NHLzkWbXOvBHB9cM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789662216; c=relaxed/simple;
	bh=xzO8BptV7OQfhikq9rpWbO1fMzxV7YYzvbJNnZ0564o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sb79yFdyYcc0voBDoHnWozcb3TAjOBEDH+qR955auVNp2QB3cnZkoATdyAi6NatQ49DNbWuay1nRI/IgKgbzH4a9F5Xlbv2SywYiXqX16UkPIZ6CgSB/5Db94mGJ59eZrE1J+gXROCchyNaDts0U4Sy1Z0MCVlG7lWtRvz+IfOE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=p+rhBbfi; arc=pass smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p+rhBbfi"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-48442ea8f59so392113f8f.1
        for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 09:23:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789662212; cv=none;
        d=google.com; s=arc-20260327;
        b=HLifIdtrGzwUHl4PrmSnm2eqFQInjlNQObyclbJAPwfnAbE8onkQC0yb2BcwbyM1NR
         6zETPaS6TRSt6YnRfbAwWLOj2wkWj5XMOq4fUloIZ5ezdSgTrC6v7GF2Bsjt3uCcvf8z
         MtePTnnPsgc917Pa2khNOmTTdJ+FRJ6ta90hyxl9tO2/RDnGGOuIiKjAKG7GtIDfrSY7
         Vym+AOsEWe42w+NkPo3W8B8+m7Ga50/gB0snq3wWkwV3NIqltIyseCt1k3Ok55RTGZUW
         QubBP2M9uBFz4f0oVGmRM0Dp6Iy99bIkCRGU4dVujOl4+0i0DNY+NS3y6VyG5GeSSu1j
         JKwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xzO8BptV7OQfhikq9rpWbO1fMzxV7YYzvbJNnZ0564o=;
        fh=s7oeDfiwk9hshZI4iZYtQ2YTdr73+uoL+oPaw2DN414=;
        b=dytIoni7ie3AzYb3HKQ4XNJ/RrxK/P+SGbeWqYzomh914wcReciGPJ6PB6xzQyffYe
         4DIansgUggSFhReTRYoWLUcN4n0flwe+VfjWA0SQHZ/MO349BesArLv0/ISFIyeUPj6b
         K9v8GlHMUMWLohu7GF4EvEG6XfLiO4K1D49rk7H84ncHHMPIS7obM1V7IuTu88o81Iuu
         C6g5qZgidqn9/We6CK/4ezRsZQ3dSYv97TkPidjohU3H4rAZ4mzWfyEOr/7pX1172RT1
         Ixqo45Qrtx6KTJUZvjvKygjCP3yy6oD1ksjfFiueElX2kRaDoFAJVAwhshaZC3YJde+W
         xYHQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789662212; x=1790267012; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xzO8BptV7OQfhikq9rpWbO1fMzxV7YYzvbJNnZ0564o=;
        b=p+rhBbfi96UhErZI6rxsFeqivT0oXAiCfsfKhfm0zP50VoDXHgBT94+q9XTL1FFJXv
         6DI613GT3uNm5VZ0KtUBOw4IOUoFsja+U0orSrSIgPbXRbTKmnSDje77v5MRDx8r/HkV
         D2ZQZsErLCnQlPhrH+h2yUIxsIfrIjrhJO5HfQxj9MNQWEE+XK65/sjVd5ej51s6p1+Q
         RruVvW6RltNy0jvj/6CC7UAafc6GgoeskMqTjbdwdwH/i2Kt8LwNmElLyIphlPqrxVWy
         fIDAQNWsJmGGQvCE/AsAsN5G+KGdX23xHhcHtTc6Sa6p8oUD94cKbjzQs1Q5HqMhdEe+
         m9pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789662212; x=1790267012;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xzO8BptV7OQfhikq9rpWbO1fMzxV7YYzvbJNnZ0564o=;
        b=UewsSnbxg1ufoQKIpumErvjGxk/rYE5QPacXVQAnbhLnqCwfzzdKhuBcqVpH/2kukG
         mrim6pZMhVMTAe7+De9PLOGQNJvcrbcPcko3/j2gpNX9PljAV3AsjgEVMIWPJh8QCmI4
         DQhBZXTDNkNOa1uHEbWF+Sjo2+ZD9b/AtUmZaAc83oJ9K/X+Mgmp/uZHR8XN4n4n09vD
         WAzxpFxNIKJc1vIEM10ffutDzmBvalmqA2ybEwf0Or85QqyAI7Wfu2qiloK1Bivlm0G+
         omyZ+WtQqxNqjQive58rKjTU7T2Vx83pgEygGOzbVxVoVHxKhFUllD7WEsnrMvVbZNOA
         XLVw==
X-Forwarded-Encrypted: i=1; AKwUvBzvNxAvsroB5/GA4oGrdJYIjzSN2JfMYf0DepuLVCDR3jDIPaAxOqPZ2j9BhAFvLNzjQpgdfDA=@vger.kernel.org
X-Gm-Message-State: AFuF++miV9pFnWvbA8w9DJ/tProasLHeRgaLrqIntv+cT4oDGT7kVzWX
	V0kQ9RGVmfKN/5Oqb313+tpgyObZXBirLBnLyAgtawDdntY8xKssJ1G62I3mdClT2XTdAPlnYbO
	GtHsubqOSh8Y/dHSJIn6wVcwCKn9ueQC8eyXudk14
X-Gm-Gg: AYBFou14T5KMU5J1Po6LpdSyJpLXl6hhfepMoByQ90EyfvZGN7Wx//CE3cpm3I+Ltbl
	MHlHSqd5xp1xqL4O8ttEWs5pHXvYuQXhppa/4FACzLp31FzM1CxSkZInHFylaYvokS3ggiIUw7F
	/Pze2M3JdKTDrQnCYCHaPWo+dAU5A/dZretPrmgFDXp1w/UaZB0PPe3y5gSffiaFIKsN3d/mScT
	0IHNxfSOSYkhqoK1ZppkS+lj8g+ArFIk1dRBZNi+41FxRTa4gJZrtUTLCTsA5mmgmQMlGvbUpdl
	STQ3pPsAsli4dyYdUMD5IB4JK7X7idbNic7b7kNboEhY8za0EL/fR9xfGp1gLTBgF/q8utvmfoO
	6Cf4s6W3khh9uH3IO/T5np1A=
X-Received: by 2002:a05:600c:c0d5:b0:49f:bd43:5a1c with SMTP id
 5b1f17b1804b1-49fbd435a63mr53248585e9.15.1789662211802; Thu, 17 Sep 2026
 09:23:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260915164000.124340-1-sagartaunk@proton.me> <aqu0bzgMAUQe_LZ6@google.com>
 <OFpa5lCrCbU3qGep0CtUhaT89qRwVqHY_LWoHC27noLYmjqgp8kAvHrnng6MEzqlqF3zvapYJrpFBpfjf9XiNfxtR-GwhnFMeIj94mKfKCE=@proton.me>
In-Reply-To: <OFpa5lCrCbU3qGep0CtUhaT89qRwVqHY_LWoHC27noLYmjqgp8kAvHrnng6MEzqlqF3zvapYJrpFBpfjf9XiNfxtR-GwhnFMeIj94mKfKCE=@proton.me>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 17 Sep 2026 17:23:19 +0100
X-Gm-Features: AcwNN1VD1F2eURP__bw4VJs5iXLEi2YyIyAvyAh6K9UFqZkXxZxEIhBqNTgRpjA
Message-ID: <CAH5fLgjrQO7Yo1PkBU3r5Tw36pRBRU37iCp_ai6LOj1XH8mBsg@mail.gmail.com>
Subject: Re: [PATCH v2] rust: net: netlink: validate attribute length before
 casting to `c_int`
To: Sagar Taunk <sagartaunk@proton.me>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Tamir Duberstein <tamird@kernel.org>, 
	Alexandre Courbot <acourbot@nvidia.com>, =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
	netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 17, 2026 at 2:45=E2=80=AFPM Sagar Taunk <sagartaunk@proton.me> =
wrote:
>
> Thanks for the review. Also,I wanted to ask what do I put in the `Fixes` =
tag?
> Like the commit which introduces it or explain the problem there?

You need to put the commit you are fixing. Please see
Documentation/process/submitting-patches.rst file for details on how
to write a Fixes: tag correctly.

Alice
