Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707A441DDF0;
	Tue,  4 Aug 2026 07:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785830373; cv=none; b=bQBJR/iwiI8I8745KxrgnW5gPIVgXPn9lKpQp8mEcqp3gymlx2WgUnX8Lk80gZ8xvvJB3lr0APAQBEKY/nWd6aAjZ/rPPjvpQgaKWHCBVyvsCwDdWee8qlGvN3HKjs1BZzxigk2vJ0dZO4MKj5s+ZcXhOug8KKoM+SbFwfI96eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785830373; c=relaxed/simple;
	bh=zst4gQXdUf9wIFeWVzHRmEgbUh3H7cqmNaSN2phfHP4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VKGjRwigNzFIkLDQZ1Z6fJkoFF5YsfPACLY9NW/qZYim5BGlNJ+QZ2Jzy/zR9QUOmvXsN4h2e8zR7LPZ9DITSwT3rF+7oY0KcGMeJ7uJzbikh4U912m773YL4P6VcN56r3aBTNFvVKqiAsBzju7yGKXEo2OGYGEJPaQdP4admFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HEBnBRSb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HEBnBRSb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 184AC1F00A3A;
	Tue,  4 Aug 2026 07:59:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785830372;
	bh=XFxakEObTj5ILt5cc6UMrFBA4R2PYJOH6KLglW0VZUA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=HEBnBRSbawyk083vGvvKdEbDf5vihi1OOpO1vAzkk11NCROBU8Ej4mDcVliwr5EjM
	 P8mqXj3BMNHjIvaVuMlGGSenTG3QGlXDdS0uUmhF2PenrH+hDp9aO3zSxyKgAfFKNl
	 VXXKrE4ZvMdnfQ8LFRLK2wNjFP7Jw8W8HhQGgtrTV0jnxJYeFL/rU6tDmUw/9LQ5rT
	 qqRLF7QB0yTx7mtonjlQ3ao0iJfsyTHg3aSDiQAYpEcHN9Tk7SjQ3NBTjf/P8kGiPm
	 0NjhWfM5vy+45gXYorynlnUdSUsNjXsUZk9oj+7Qc0HSl/ySN+6Sri7KgSNOklq9CM
	 wtc4rhBoRjVLw==
Message-ID: <6af71dfd-37b0-4489-8b7a-63478c8fdd4c@kernel.org>
Date: Tue, 4 Aug 2026 09:59:26 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/5] mm: Add RCU-based VMA lookup helper that waits for
 writers
Content-Language: en-US
To: Suren Baghdasaryan <surenb@google.com>,
 "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: akpm@linux-foundation.org, dave.hansen@linux.intel.com,
 Liam.Howlett@oracle.com, david@redhat.com, willy@infradead.org,
 shakeel.butt@linux.dev, jannh@google.com, aliceryhl@google.com,
 arve@android.com, cmllamas@google.com, christian@brauner.io,
 tkjos@android.com, dsahern@kernel.org, davem@davemloft.net,
 gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, netdev@vger.kernel.org
References: <20260802215459.2769283-1-surenb@google.com>
 <20260802215459.2769283-4-surenb@google.com>
 <152ee467-b5e4-470c-ad95-c638aa9986bc@kernel.org> <anCst8u7ybHf39n8@lucifer>
 <9c301dd5-76cc-40dc-bbab-a79559d6db1a@kernel.org> <anDBVu0PIzy7dks-@lucifer>
 <CAJuCfpEYFs94heKZn3hikYuCJU3CEHr2u1SSxXMyFQwHHAcjDg@mail.gmail.com>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Autocrypt: addr=vbabka@kernel.org; keydata=
 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
In-Reply-To: <CAJuCfpEYFs94heKZn3hikYuCJU3CEHr2u1SSxXMyFQwHHAcjDg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 8/3/26 21:13, Suren Baghdasaryan wrote:
> On Mon, Aug 3, 2026 at 9:44 AM Lorenzo Stoakes (ARM) <ljs@kernel.org> wrote:
>> Agree this is worth spelling out in the comment (I raised similarly).
>>
>> Maybe something like:
>>
>>         If a VMA exists which spans @address, return that VMA, read-locked.
>>
>>         If no VMA is mapped there or, very unlikely, a reference count overflow
>>         occurred, return NULL.
>>
>>         Nothing prevents VMAs being unmapped/mapped before or after the VMA is
>>         looked up, if a stronger guarantee is required, take an mmap lock.
> 
> This last statement is true only if the function returns NULL, so I
> think it should be in the same paragraph as the "If no VMA is
> mapped..." sentence and prepended with "In this case...". So:
> 
>        If no VMA is mapped there or, very unlikely, a reference count overflow
>        occurred, return NULL. In this case, nothing prevents VMAs
> being unmapped/
>        mapped before or after the VMA is looked up, if a stronger guarantee is
>        required, take an mmap lock.
> 
> Does that sounds good?

Yeah, thanks both!


