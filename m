Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794504538;
	b=QQT/SR0o4xRf0TQW7V/BtMxJO6mqyLA6VQw83mvTDwbnV3vtGNiA8+HgVPr+XX0FqpmH
	 dY9HMCY7rgHcXDXS+lLsrypQE9aVvBXs2s5QuRz13Vb9ymM4N7/YGb8KvRy9eaAEahFb6
	 fTCgLybtF8yGx3uzkAPZMRbxIdXQ8Kuy3FtIkRheK5UzO+D63sfbidlXRK4rqRjsTbSqQ
	 daXpECMVj4ygE3P/cDTPbyhTcGHEHR0Jz0kdx8HGvCfVH5gInAnUUQ4HnDbb725FOg3nF
	 pbFKsufbgYQvWELZC/MrdLkgPp7dCRa05vcWGcszydr22/XhGOQrcu3Zikm+vD0epOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794504538;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:X-Forwarded-Encrypted:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=AVq19U8dsLUULl5Arm+uFElP0L4F8s4K16OEcmVJkjM=;
	b=NEd8E4q9pNiD+tPrZJa4/1v04faV7qYrf6DLo1is19S8yMkwsYF/wrjirfU4x908Bcgn
	 V1I/YwGKbjUUjpINo6PCCLDYVlUKFAhG2dYs+BlPuks7l+0UGu3KiplyaZvKW8P2V3hR2
	 kclWjq6lP8RI1ah1LWrkHFvTU4baRiEL0Qru/IxtNfdtc86UoUYb7H3Z60NeDCvtlGVhe
	 CxgaQh/4HpWbuVj1H+ohmAXHklyhwbzqBP19Q1ak8UOyxrwvmddFR/pQ0rR29+R5jcIaf
	 dqisB6EWCOdd2QKdYGVUn/pILTymIeWpbVNb7hzHPCw0nW0gUZmqqjRgFOwYmeMyGIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-foundation.org;
	spf=pass smtp.mailfrom=linuxfoundation.org;
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=S3nK3x1m;
	arc=none smtp.remote-ip=209.85.218.48
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F13606A32A
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 17:28:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A9F13606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=S3nK3x1m
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c3f04e0e65fso685678066b.2
        for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 09:28:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1794504536; x=1795109336; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AVq19U8dsLUULl5Arm+uFElP0L4F8s4K16OEcmVJkjM=;
        b=S3nK3x1m6MIyAvTvBM6t0IcZBzEI/XjJAGj69KGtJ9X6it7Ui6dIUPODj3h/yBg25g
         tKZW0zWl3+wQpyB3njyWOLzyFUSV+g1KW0HKZlPzDTB7vTNJzpqcIJjYUSJBm66He9r3
         /gr5grYQenWUP78Wca0GgMlRwAi9gwBiZQsCg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794504536; x=1795109336;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=AVq19U8dsLUULl5Arm+uFElP0L4F8s4K16OEcmVJkjM=;
        b=H9juJCOqghuxDo6VSo8rFCkF265fSIKePBu/gNM4T0jCQvZG/1EQto3qJvKAEfEGo0
         +mZsILbbTgAMaLXAfwlQR5QNjKJALE67WJUUML+r5raqLg9DgjmqkOVNGCswDQmojENQ
         1MeZdDo6i23O60MOjIzyDTJ/N//81byBxKfSYvvVXyDFNf6kUL6NX986FI6triuo9tRX
         YjDfjWkIzlJtFU0wPIQ2z3M1u2/4lV6U10yziULPfMqwIyPXm0f3UxrmICMsNVkS8/X0
         N+VT8BZCY70fMTT7GbqqXFcgToWyMRW3C7O1rlz34wkiin62u1vIQW+lAnDyl8p+BAZ9
         ESHA==
X-Forwarded-Encrypted: i=1; AL+hErELm3G+BCG/fEkTD5BH2vhgX9B0MMJdacUrKZfhe9RgtXMl9XLv082bRgLClbb8Lhdd0XFarb0=@vger.kernel.org
X-Gm-Message-State: APuU4Z/Ls5kSQmq5to59hpSJ9+a3iMesZwsq7PgE3RU+EF5gsBE9zq/c
	RHdgDIe9zpldXP7n7Iio0/EoLf5sbtcwYQSe7CDX5vNVlFodgWaUK8ivFI9QXhEFxSIA2rCSZe6
	uNTVt/DW7Kw==
X-Gm-Gg: AYBFou22ONT+RscXG2uyIildEREOdw+sdSTpXXreil+YNB5LaqarD3onoOWCxv3vOTf
	kh06K5yB4w2xmBabD9HyoERGFZ6SAqs0iM5VgmwuxNiDHIorZFxtGt5smWIT3G8QBopdaOEvq4A
	TuRHTY0uBkhBGurnuS2Dzx381UzFZ9H/2/T6l2/EFo1rLBjiY+k5vPoG/K6wPB73p9IrlwfO3+L
	IAtGTspwp1V5zQGMkg1i8H5Aheeik6PodUVfqWyN51nX8OjvLzI8f3W1fTR1Ss1Tce3MZTM++O4
	FcbFHtMa+1N4/u7zs2DJPJF71dGJeNyRIN/s88y/UmGqaQmp/qcLi8XDEkEizgT2EEi73PWEbGj
	ZH43iw5zF/j6jsIwmmpw/5U0wylfEjuQWdQPqwk4m/Sbld3ENNaE2ZaeOanV7pS1fpKftAUwMmp
	ZF1E1pMLan1QNRCWaHUXpe4pD4J+ss+DuyhcfMkXaE1Hwocx8mBHROTFVXi41UXSiVG4qbX7InA
	11is+I0i6OS+dBH9JOXvwkLbTwm8WwvUDR80F4ib46NNtc8K8GWKkgspLUZlnuTZW4simfaY/f2
	mAqc7/Dzh3YGenoBJLPz2SnFc98RAg5+mPPZF7r4QOAU6ZPLv4Oh25ZdAjv1vpyCG0mkElC+Y6Z
	JWYE=
X-Received: by 2002:a17:906:514:b0:c50:8ff9:4f40 with SMTP id a640c23a62f3a-c508ff95a19mr128732366b.11.1794504536041;
        Thu, 12 Nov 2026 09:28:56 -0800 (PST)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com. [209.85.218.47])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c5095b23b1fsm1250766b.21.2026.11.12.09.28.54
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Nov 2026 09:28:55 -0800 (PST)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c3f04e0e65fso685669766b.2
        for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 09:28:54 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErFsL6HHT6WzqPUdp842dztS8dl7+b80f28bz/U9+cpSkYkCBUe5E1pMaj1whRvQOkuHaeMChjs=@vger.kernel.org
X-Received: by 2002:a17:907:3ea7:b0:c4c:e344:ece7 with SMTP id
 a640c23a62f3a-c5066afe5dbmr615605366b.10.1794504534261; Thu, 12 Nov 2026
 09:28:54 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261110-refcount_overflow_stable-v3-0-318625d63a98@kernel.org>
 <20261110-refcount_overflow_stable-v3-2-318625d63a98@kernel.org>
 <avW3v-oLxcHXXNQD@pedro-suse.tail5790ac.ts.net> <4ae22b7a-c160-4003-a029-8a20381d196f@kernel.org>
 <avXFlI_5fhUvFyct@pedro-suse.tail5790ac.ts.net> <42373222-8e37-4658-bebd-dd27230a1dfa@kernel.org>
In-Reply-To: <42373222-8e37-4658-bebd-dd27230a1dfa@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 12 Nov 2026 09:28:37 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh995y1B461rPAcgLagg26vsyXPoe=7JKgHowB+uHJJXA@mail.gmail.com>
X-Gm-Features: AclHuK90rViBZMbITCUjh4KTAKhE7_4EYJcdTbdgYzXWPc1JsLWFSAsYMdn-r7I
Message-ID: <CAHk-=wh995y1B461rPAcgLagg26vsyXPoe=7JKgHowB+uHJJXA@mail.gmail.com>
Subject: Re: [PATCH v3 2/9] mm: limit pagecache folio refcount when splicing
 into pipes
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Pedro Falcato <pfalcato@suse.de>, Lorenzo Stoakes <ljs@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Andrew Morton <akpm@linux-foundation.org>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Nico Pache <nico.pache@linux.dev>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
	Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>, 
	Kiryl Shutsemau <kas@kernel.org>, Matthew Brost <matthew.brost@intel.com>, 
	Joshua Hahn <joshua.hahnjy@gmail.com>, Byungchul Park <byungchul@sk.com>, 
	Gregory Price <gourry@gourry.net>, Ying Huang <ying.huang@linux.alibaba.com>, 
	Alistair Popple <apopple@nvidia.com>, Peter Xu <peterx@redhat.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Song Liu <songliubraving@fb.com>, 
	Rik van Riel <riel@surriel.com>, Miklos Szeredi <miklos@szeredi.hu>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Hugh Dickins <hughd@google.com>, Will Deacon <will@kernel.org>, 
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Nick Piggin <npiggin@gmail.com>, 
	Peter Zijlstra <peterz@infradead.org>, Arnd Bergmann <arnd@arndb.de>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Kevin Tian <kevin.tian@intel.com>, "Joerg Roedel (AMD)" <joro@8bytes.org>, 
	Robin Murphy <robin.murphy@arm.com>, Steve Sistare <steven.sistare@oracle.com>, 
	John Hubbard <jhubbard@nvidia.com>, "Jose A. Perez de Azpillaga" <azpijr@gmail.com>, 
	Josef Bacik <josef@toxicpanda.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, fuse-devel@lists.linux.dev, 
	linux-arch@vger.kernel.org, iommu@lists.linux.dev, netdev@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 12 Nov 2026 at 06:31, David Hildenbrand (Arm) <david@kernel.org> wrote:
>
> On 11/12/26 15:00, Pedro Falcato wrote:
> >
> > ETOOMANYREFS I think is good, also EBUSY, EMLINK (though this would be weird)
> > or even a generic -EIO.
>
> So I used EFAULT because that's also what we currently return when
> generic_pipe_buf_get() fails through pipe_buf_get() in splice_pipe_to_pipe() and
> link_pipe().

Yes. It's not a very intuitive error code, I admit, but:

 (a) it *is* the error code we already use

 (b) it is a fairly unique error code that isn't normal (ie EINVAL etc
that can happen for multiple reasons)

 (c) this is  something that nobody should EVER EVER test for anyway

IOW, the actual error code doesn't matter. Nobody sane will ever care.
Some of them may be entirely unreachable due to resource allocation
issues. And we already use EFAULT for random historical reasons.

                Linus
