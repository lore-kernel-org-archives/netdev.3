Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792488098;
	b=GNdRVvBFkni79uEkaktM9Dx4m7MHfpPNz1T2uzFhP5FlySXkzMFGW01SiTNwmZb5AXCp
	 sIoMMsIu+S1+M3LEnYxkNikWWFns9KadujwrMf4b5eD0GHeiMHhrNfpk4UD9fp7B57FW9
	 zJQ9mDGc0KDz01dSbzCSc2VoVyXvd8ZjT/+S05YVcAkRBesJ/sHHGCgbdnfdUeQT4uIfa
	 aeQ7WDuKQ/QlKptk58bx+W+0Q2Jpm+xawFHzZtjFkJVB6AnzhJ20GxNH49PY01qfOKchW
	 Nfb2qpLlNnvBDPKMtPtVZ8TmDDBFxflRSdgBUA+IpC9sD/v/kLrwR899Iwkp882v2IQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792488098;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=oK/+sZCg2jpdsH2ljNfSqzCUTPMd7ZlHvWodhd0LpQk=;
	b=bq4jRPbRjvf+ZYuk3M8U8DCXOMlCXFC/AeFxOkn8fRmwnqTWl2pSgfxqyo93BRlH/38n
	 PL6YUDiAqTeBaJ9oVnW/9z4qfK1/8VXY+UPV49D0Q8HZfSBMec/oayUMW4vuK6KQhmHn0
	 wbd0WcFaMJQZfO396Yh8WchWz0sYf6SbeX+BPUvS2YdTHCqDy8EvQ9LbkQSDADFr8EjQY
	 8xQ0ZXghvGKIxABAc16yDrupCH+gaWm8QKfF5x/Ewl98Qg8LQt3oX7/11Zx6zCn3ACXuW
	 MhXfDNntRexrGu6NKkh8NDBO79u0QjYGn9+sMHqYJsM+BFXxKmoEiEHgvoLPZjt8Z5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=mnlX8hbn;
	arc=none smtp.remote-ip=209.85.221.53
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87390606A31B
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 09:21:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 87390606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=mnlX8hbn
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-48c4be28b82so2302931f8f.2
        for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 02:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792488097; x=1793092897; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oK/+sZCg2jpdsH2ljNfSqzCUTPMd7ZlHvWodhd0LpQk=;
        b=mnlX8hbnDVujAjRfxHok9GymLoWmm6QQmreatYfwiSqmCGOo4mQX8F6IOAfF1Pqn26
         rzCT2PlD/LfYRDBemmfmSKyVVNUms71F2HHScJzPQ/djzhxLSKegU01GRzTSDxzrLB8i
         7qmTu9s2S7tIpbfXzhAoWJiDSmXm+xeJrlhgVBW4GnK++N1xgfapsWBcrH5aU4Bf1ogH
         wrmXJIjqQUq42yPPqZ2s2wA1N6DDoUV/zrZJR7uJ3VOlZY2joYtc6cTRBl5zcYJTo8sX
         Krb88W9kMQxaMPdohOeNM7T+p6qXoORre3KBJjmYH0dNckbVNQ+VIZZodPIvoCoftf5I
         8V5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792488097; x=1793092897;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oK/+sZCg2jpdsH2ljNfSqzCUTPMd7ZlHvWodhd0LpQk=;
        b=ReXwQ7MXAIqGTAcxn4EAlnn1VdiISgDP+ZKrIOH5fMLSCasmCn3lhibBjAdCBFjiKA
         SCZl6KY3z4lVhNhVl3M6IIuW2FminF4KaLka45Rs7zDIKJpc5cy5NHe2sO6NB6YoB9H8
         k8Vj8ksoW2lTuFlF8kBK+1ekxfCghr37N1OZk4fQ5JjLEaQB/MEyu3k2CektjtxMg1xB
         4J98WpwjAPp2AsccY+6iYc16zx5rbsxetxShu62fajT5nSoAYm9Pj/a09y3W+YC7iaWb
         F+D47qdYB8oWvvVvzX9RbHusEvGTlOr9atlmdsMojpcwSF3GcV47SB7dwuy+Ve3AR9M7
         nPVw==
X-Forwarded-Encrypted: i=1; AKwUvBwb+zkCQz9uSbUWnPjtuIwv3Kk+nl1ucDiq1aE14j/KTYlLxBUijeVtrCmlKAo1InZ8KSruPuw=@vger.kernel.org
X-Gm-Message-State: AFq9FYIvUNV20iE7XQY3JE4Q+DzTDzAqyuYKMed0aETck7MkK4NGsmeS
	p8HuDEzjCe6YejinVusPRslU3RL3m2r8At0QOrel6uLLsIZXJDcvz+Bj
X-Gm-Gg: AYBFou1bfrFzUc9+nr1uTwWaWhXLS8KIK8ay70C75/FcJy2cN4uGwxSeEeqPWrt+fIg
	hgIK8pgBqW/5ArGQ8JS0pCGX6El8kHP6fMS5pc3sPYEz4EaB1q4UXWVMoj9MFUAzVJboNY+NmT9
	/cv04PEJKgpnYbQNrz3sH4YoO3mlizc0OcaUxF/Q80WnIWjkl26aadU96GIc1uMalKa9t3xbUJK
	eXfBcYjPMlfBNDhI7C9CUj35OfL4PeR+OwReRb27dmRolgQS4eVtafriI49RjM7lrm0j5jVhgSj
	6yahka11rwD4TQDS11Y6BN4BYUVfgTleFejPUpeIrTM9i8YILmXrvKBLPkpctthojYYLui6fhTD
	nJYJmNnqqw5sMv7g46eeH6CiOqc1uNrX/4lL2EgNIkkc26rYfNdcUOfIcla7bk7JNjvw+a/NP4I
	MhSx5LEb4amI+jq/CZOubkrTTMdWglFnb7B32WtUlW7NcQfH0DpYGtw52K2/fhKAKdZUg56+uSh
	1rtF+B/eQrwyO85BAoohu+FsGoNsCYU7rk=
X-Received: by 2002:adf:fd4c:0:b0:487:27f9:841 with SMTP id ffacd0b85a97d-48e07fbdfe2mr15044578f8f.54.1792488096337;
        Tue, 20 Oct 2026 02:21:36 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e1d80f9b3sm4629943f8f.20.2026.10.20.02.21.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 02:21:35 -0700 (PDT)
Date: Tue, 20 Oct 2026 10:21:34 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Linus Torvalds <torvalds@linuxfoundation.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Wang Haoran
 <haoranwangsec@gmail.com>, jasowangio@gmail.com, kvm@vger.kernel.org,
 virtualization@lists.linux.dev, netdev@vger.kernel.org, eperezma@redhat.com
Subject: Re: [BUG] vhost/vringh: __get_user without access_ok leaks kernel
 memory via vDPA passthrough
Message-ID: <20261020102134.745ff48a@pumpkin>
In-Reply-To: <CAHk-=wjxtzD1TXZr5iWu0p1+Hu0YZP7jbNSwFkp7AJYmhzhVCA@mail.gmail.com>
References: <6ad07f8a.a0c71a5e.2d2efd.977a@mx.google.com>
	<20261018152358-mutt-send-email-mst@kernel.org>
	<CAHk-=wiUn9EbV4TJ4J7OPY0fVc3UC+xb-pp=+rg3hRc4jQqihg@mail.gmail.com>
	<20261018174250-mutt-send-email-mst@kernel.org>
	<376ef9d0-b03f-4f85-aee5-46cf20eb00ae@gmail.com>
	<20261020021924-mutt-send-email-mst@kernel.org>
	<CAHk-=wjxtzD1TXZr5iWu0p1+Hu0YZP7jbNSwFkp7AJYmhzhVCA@mail.gmail.com>
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
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 19 Oct 2026 20:51:43 -1000
Linus Torvalds <torvalds@linuxfoundation.org> wrote:

> On Mon, 19 Oct 2026 at 20:31, Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > The following seems to work for me. Testing would be appreciated.  
> 
> I have a whole branch that removes __get_user() and __put_user() entirely.

There should also be very few (if any) access_ok() calls outside of the code
that implements user copies.

David

> 
> Somebody should check that I did it right. But I didn't want to do the
> pagefault_disable() around the vringh_notify() part, so it's not quite
> the same as yours.
> 
> Let me just push it out. I was going to let it simmer, but your email
> made me go "I should just let more people look at it".
> 
> Mind taking a look at the 'uaccess-cleanups' branch?
> 
> It builds for me. That's all the testing it has gotten so far. Blush.
> 
>                    Linus
> 

