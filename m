Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793631500;
	b=o/OpTqYOSKhDmSMOOj344azLqr6pak5GL7OXHSqUgEomY3PLKDHIqOVdgynwsE5DCcXb
	 Aa//k6PXPKRC+tM+q6ybzmkbk8adcCpcOH2hxEf3rAdmjsrE3n2HIBT8IoVcpcvTmFYI3
	 v3JTI7zv1hhTDL0QlQNkSzFVRbdFxfSB+7+clEE+yiKXp71RmKcDbKuvEASR9L9vHMhpQ
	 G1vgQcHCUNHs7whfrLk6t+yRQLksGJZPVHpPcQDxOFePa6FwvZ9bvnIskVENR4leEdevT
	 4VDnI9lun9RRmiAmQgZDUoRmrx/ksN2ltinwxY5VJd3HzO+nkk7fJX6qxi+Vy/wF9jw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793631500;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=RjJ2Hwu3lUOd6ON7ncjs7o5wy86KpEGCg7RvieuPzxo=;
	b=I+Sgo4tZ1jwU5GCOM12Q8sCkYlGfLTgiJrhj/7+dOWuqTVW0c/qry4ZmuYKHuo2Up1jd
	 UFQxbKB1saCmEEW1YpLq3f/jawcWyuzV+xrspkbu/2iv9BhIyxH9loHULAHFMGJah/Xgv
	 /jdJKPr48mDBx9X+sIz9ME+7S7nslJp1/B/N1ha/SM5C7jjMS/ouw2DCtiO7P30qWtfSs
	 G//L5rJAnbKuimNF8skpBqNSYqmf/N3dMfapJ1ndr/TAzt7RwbOoUJ151Ud3EXuU7dYBt
	 mt9rr208AEHC7bOqy17AiPox/MWv+TJNiQZf1IDC/Trdo0BQ5fgpm8dRJRLwc2IpKlg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BrbU1JVM;
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8004F606FB66
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 14:58:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8004F606FB66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BrbU1JVM
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4a20bde60a0so24011125e9.3
        for <netdev@vger.kernel.org>; Mon, 02 Nov 2026 06:58:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793631499; x=1794236299; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RjJ2Hwu3lUOd6ON7ncjs7o5wy86KpEGCg7RvieuPzxo=;
        b=BrbU1JVMgXDshJJm6OHdhOASL1Y8s3HQCSQbgpmxovEp6pdFADDlyUSCWLkbtYPV3q
         8GDaUpmiAwHyn4ySNmbBgpYJLxSAGu+tbVIw5ngdO0/ZJoMhE0B9YWXbYtExpTB0a/Bs
         fXGhljRQ2qfBNvaIfdvZWJd52v1A3Fj1x3Uw4dsNqyhamOugevEBMGc/328+EU6G8VV/
         gHF8FDwHtv4xCoGup3NutYJHXCQU+SYH7f7Uawf7BC2eHAMpPXG+haxmNfEGtkLeXSbC
         ovBiZBjHjdYNsR/36m8DW1Co5/9qZtugpPlNSu6tPWpE9bs34JFQni0D2p84wG/ZoHLf
         VcdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793631499; x=1794236299;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RjJ2Hwu3lUOd6ON7ncjs7o5wy86KpEGCg7RvieuPzxo=;
        b=MoO7c9MRbgTKrALDbwjqxENowYdNrFguL5xP1kgP9vVS/ZJMibx8EVudooBSLwdS4d
         8oTo0/YQXM/tVAuAFSIr1JIuBV5m4Kd6ROiuSWRuQxJY/repcNw+jPSBr8ftFEAmblTq
         FLVj4oGC3agBeDL7rHIxW/yz0liIuQ6bZIZfGvlcw7Ua1MURreVhODv6E91xlcOtnmJk
         bNDEh7utw5puratOHOG5Rf/uT9S1OwSzC+AbD6Yil7Q725H1NNcnhgg36hUNsySXvs5h
         EWSuc/owhUDGyowQDo564bebXDWKrkFhlUky419PH8PZ7Syv/gTIQxwgvk3NQvVSCijA
         tO5A==
X-Forwarded-Encrypted: i=1; AKwUvBxXkHHEbFBZj5w2G4SKy6VC7OQ9rSV68yq/Rs80cMZTnTqXYfJNnp6UBZwUVIeaK+jZ1A1oZlY=@vger.kernel.org
X-Gm-Message-State: AFq9FYJAC8px6hv/934YqdPb6H/RhtVI+p3MJQYr4NPAivE16/+ynXwW
	WWgZS6zystfGQlosCD5YlM+IZmNUXbNldkXJyDkkTeJQ8ARh4Im8j7de
X-Gm-Gg: AYBFou3DoPx3Nwodcfy9Hfu99Y+eenOe3dqKfOwPGxV67jW9i1IO/J5u1oDoMsK3nW+
	HaRa0f8lMJ10UQA8YmbRfLBlQeTn9gjcf/CmAKinCuUkVDYd2sS8WPzz9zk7InL1gBA1dRBmea5
	MqGj2U48IHZQKjVPcYdKhax1isUmmN3lrRg4Xz6Z/mCUc41yZXfaQpebiu51Budr/IEd4b7CctE
	4psqpmSI07CjPJnJxlqJD3fgC/nXEXWBrsYH7l6wEXyDCQWvl7OU+IuPYUkGTY/BfD8R6IzA+m1
	5xcpL/NFe0HBU85XB3DoavpaQKFYft6uWqgEar2IVEPOZvERbZTS4ep9U24+jjJzR8+E34Y5IMC
	jp3h/jrH+CmMzGx5cf/sc9f5aI7sYXR8Kg4p9O6RtHcXqA0UOGeCWlmoH32rhllSffF8Y2oM01c
	/4PmXZkleq1tmAqefcX9/53jyNKp+x35qht7ZliOQHrIITUhdGbcC0wPptNelNfEAi/B8kVMFlN
	wpahOz3Gt6VQNJHhrKxlkg8zq1qaOIbOURyjhonHInVcnHd/17gfwuiMhB5cb8rpODEJ+vobR/c
	QQ0hbXfk/SxUF6oMyIFIZUWcKF/3KQp9VF4rjJO4ZyrKexSrX563TYhZSZ9x69Bn
X-Received: by 2002:a05:600c:4585:b0:4a7:8fe8:130c with SMTP id 5b1f17b1804b1-4ac1889d5a1mr230617865e9.28.1793631498658;
        Mon, 02 Nov 2026 06:58:18 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ac0b4df257sm164791725e9.4.2026.11.02.06.58.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 06:58:18 -0800 (PST)
Date: Mon, 2 Nov 2026 14:58:16 +0000
From: David Laight <david.laight.linux@gmail.com>
To: saeed bishara <saeed.bishara.os@gmail.com>
Cc: Demian Shulhan <demyansh@gmail.com>, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Eric Biggers <ebiggers@kernel.org>, Andrew Morton
 <akpm@linux-foundation.org>, Marco Elver <elver@google.com>, Ard Biesheuvel
 <ardb@kernel.org>, Robin Murphy <robin.murphy@arm.com>, David Gow
 <davidgow@google.com>, Brendan Higgins <brendan.higgins@linux.dev>, Nathan
 Chancellor <nathan@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
 netdev@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH 0/2] arm64: csum: Add fused copy and Internet checksum
Message-ID: <20261102145816.00a06c47@pumpkin>
In-Reply-To: <CAHfVqdX4AmqXs_oD5OCjU8R5ts=98=RmgCmJ3D5gLyk=Xtrfkw@mail.gmail.com>
References: <20260927131838.6774-1-demyansh@gmail.com>
	<20260927184414.6c0c8867@pumpkin>
	<CAOLeWCt+yFs29yWg6DrRH42HD9ConLgTEbW=wMKtEoTW5ROHvw@mail.gmail.com>
	<CAHfVqdX4AmqXs_oD5OCjU8R5ts=98=RmgCmJ3D5gLyk=Xtrfkw@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 2 Nov 2026 13:44:37 +0200
saeed bishara <saeed.bishara.os@gmail.com> wrote:

> On Sun, Nov 1, 2026 at 3:34=E2=80=AFPM Demian Shulhan <demyansh@gmail.com=
> wrote:
> >
> > I would prefer to keep only the scalar version of the fused copy+csum.
> > It reads the data once instead of twice, and on real Armv9 hardware it
> > cuts end-to-end cycles/byte for bulk TCP over WireGuard by 3-12%
> > depending on the core (+6-8% throughput). It uses only general-purpose
> > registers, so there is no FPSIMD state to save and it is safe in any
> > context.
> >
> > If you are OK with the scalar path, I can send v2 with NEON dropped,
> > the scalar path only, and the KUnit fix for the x86 zero-length case
> > Jakub reported.
> > =20
> The scalar path seems like generic C code and not restricted to arm64,
> curious how that performs against existing (e.g. x86) assembly

The x86 asm version manages to do more than one 'add with carry' every
clock. That needs the massive out-of-order execution unit and the ability
to have multiple independent 'flags' registers live at the same time.
The generic C do_csum() (I just looked at lib/checksum.c) is horrid
There are three dependent alu operations per iteration.

It is likely that the pipelineable:
u64 sum64_a(unsigned char *buf, unsigned long count)
{
    u64 val, sum =3D 0, carry =3D 0;

    buf +=3D count;
    count =3D -count;
    do {
        val =3D *(u64 *)(buf + count);
        sum +=3D val;
        carry +=3D sum < val;
    } while ((count +=3D 8));

    sum +=3D carry;
    sum +=3D sum < carry;
    return sum;
}
or:
u64 sum64_b(unsigned char *buf, unsigned long count)
{
    u64 val, sum =3D 0, carry =3D 0;
    unsigned char *end =3D buf + count;

    do {
        val =3D *(u64 *)(buf);
        sum +=3D val;
        carry +=3D sum < val;
    } while ((buf +=3D 8) !=3D end);

    sum +=3D carry;
    sum +=3D sum < carry;
    return sum;
}

will generate 'pretty good' code https://godbolt.org/z/K9ob6d8vv.
The first needs 'reg+reg' addressing, the second better for mips-like
cpu that have 'compare and branch' rather than a flags register.

gcc and clang seem to make a reasonable job of compiling those
(provided buf isn't u64 *).
Today it left the 'negative offset from end' loop alone,
but it has a nasty habit of pessimising it.
For x86-64 gcc is generating:
.L4:
        addq    (%rdi,%rdx), %rax
        adcq    $0, %rcx
        addq    $8, %rdx
        jne     .L4

I think a zen5 would execute that at one iteration per clock.
Intel cpu can only execute two clock loops - so it needs unrolling once.
If you unroll it once (with separate sum/carry variables) there
is a moderate chance of it running faster than 'one word per clock'
(two words/clock is probably wishful thinking, zen5 can do 6 add/clock
but some timings I've done imply that memory addressing can use and alu
add).

For slower cpu (especially in-order ones with memory read delays)
you may need interleave the code, eg giving the loop:
    val0 =3D *(u64 *)buf;
    do {
        val1 =3D *(u64 *)(buf + 8);
        sum0 +=3D val0;
        carry0 +=3D sum0 < val0;
        val0 =3D *(u64 *)(buf + 16);
        sum1 +=3D val1;
        carry1 +=3D sum1 < val1;
    } while ((buf +=3D 16) !=3D end);

I didn't try those loops when I was timing the cksum code a few
years back.

They have the big advantage of a small loop stride.

David

> optimized implementation.
> saeed

