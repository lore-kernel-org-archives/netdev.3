Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC243FADE0
	for <netdev@vger.kernel.org>; Thu,  6 Aug 2026 14:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786025540; cv=none; b=fWA4XevTNavOvpHkVp8I9YfJXv3TCze+/q6rLax+6dourDX6r6LaXKAiKB/t2LKCkaWj475cpEm+e2ujV3aqABnErJi/0jItHfGe78+uMQusGmYeeURCskEmk3FDm9MP+S+ThDAshlTUAIY4AyApbOv52YM4sBdVGB4iTu/bRQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786025540; c=relaxed/simple;
	bh=tKT2WtltnHm9yotRiXX+eFUmEP1+4NC/PxFzeHnanKw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jBRNN1xUilJv9NPXvsQgdtFesrCttiqCnSAsal4n5QqM/ociS2EHOsmKM6KV0cjz/zV5jt63BBwI5oHGtzumVmcOIiXcyH5TwOhmZt/6NVOAurAKCxpY63epWEjCwityA+dGbx8ngsQoETcEJakr0h617CU3MjvGNatdMi+6ZxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DDSODjW2; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y9MPKoqz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DDSODjW2";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y9MPKoqz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786025538;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=t7aUwMTNUpYcD120eKUj1K7e7+QcP8SwvajEqZfXsIM=;
	b=DDSODjW2B7kPo19UoGkEK/3tVTmpRb7PoklMIrw5gFEtlQUoT3Vqh7a6G+DPJuob7unnoG
	qC4DIn7hmkeLHV87OsAhZ7WBPdrHhGoFzH7b5rvp5GcsUjXdfSe7kpnXTIKspyXLhhN6fP
	sOsXhZSztz9h5TUOgUGaTvvQqcJYaqE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-47-CQAsvQiPO3mKiWwyLnHBcw-1; Thu, 06 Aug 2026 10:12:11 -0400
X-MC-Unique: CQAsvQiPO3mKiWwyLnHBcw-1
X-Mimecast-MFC-AGG-ID: CQAsvQiPO3mKiWwyLnHBcw_1786025530
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-47407691804so1463017f8f.1
        for <netdev@vger.kernel.org>; Thu, 06 Aug 2026 07:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1786025530; x=1786630330; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=t7aUwMTNUpYcD120eKUj1K7e7+QcP8SwvajEqZfXsIM=;
        b=Y9MPKoqzFqLT728N35LXZcohQ5ADY0JIS6qy8/AvNeHFc/xiiDmjr3hzEjXVczvHq5
         RFupYqJnNNTrMd3SCAmo/wcwgHfCQcdnhUJ8Tv87wx4UedBspejbTmTp3P1YHW9gODdw
         Eqfe9LaO1w2kU+B6QYVr+lMWXbtJ/jiE1Us9/UEX4XRA1vfZJ097Ibivmm3F87JIu39h
         NWTpC9hS1+LR/JzBNcPMpHD6D1LCoTs2saue42MEmAChUX9gywjMBhEyBydeWumnxRUp
         5HN5m0yTbeIE/h6dutjoJ8fazNojx6bx77ONQEvxpf02+KtanHBPRuON3m3SF8Xp0HRF
         Tqbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786025530; x=1786630330;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=t7aUwMTNUpYcD120eKUj1K7e7+QcP8SwvajEqZfXsIM=;
        b=iVZXqZItlrDyVmcfIxFkAmwePfzZO/rcCvjr0i+Fx++uTs1EazkvN1ADlQHjY6CYRj
         9QKR7p38Tz8ZlvvuQq1ixygUsSIsDED5Bw63858kI4+3o1/wedtWo6nQxqDJELXcf+7J
         m/f3+99HaooqjZgrciNLnKNg97i0inj+BTXvq4N16ChLXHgPzA2WMCrf06yBqy1tw63a
         fMuFmtNRPpCkg5g3Ymp4tOEqlnuflCi+10geDUuZp2aiDWui95lfyoDr+P+pFUE1vpZe
         GAXC5Lz9ZlXRC8noirmjdx5X33oyCKQVuUnEBunyd3Ve9Ph7cS/8SEaYO72f3Wb6scYO
         Iddg==
X-Forwarded-Encrypted: i=1; AHgh+Rrv9ZX/ceYz5SPsZqOLvkdZE/18LABiDtKh3m+JbsxddR3Ko4q8VpIH4BXzRwiVXZMd0NcTGKU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWOvzFzeyNz99eSXoW2FEjTZpO0X/IPE/LrbOMXzaBmrYrNlGQ
	owwBpjprCHRJbNx1fnem+2BSqzTDdqadizymH/kNcz+nJ7AiWpCwfUjyU70QnaFhUc2OmiaKUzS
	VkFFrGjC+3zGrVep3UOJ0dVElPMjp3MESOttxwKeUK5T7jWZxlD1uv881Hw==
X-Gm-Gg: AR+sD11XJD8F9EBhMemK0mQDFRks/kF2XPaLelXre/IjEan6f7MtFgAW0ud3lMCCk7/
	mbBP4eK0MvulpBwkt5SOMCSDp8phQh/QxoFycIOIsPVzoZ427clypgq6y6PQpgdQF0I917xdC7X
	UD1hKem5bBKr96akJMD6gei9gZnAX0U/72qBqHyUABo7ItIm7RJMQ8qRh7+1JoMedRjGTvoyWSb
	W1rnUQRE9U6m6MrJuhJcClCeUnj7X6Qz77AurUckSJkAKrhCqcmM80tyoMPKF0PmWXUGDw7091d
	UiuxtiGwQcrjdkHTdF2glsNaLxnjXQgUO4L6Wo7JarMUXxXBYPX2YSHSftq7xGQ1AgvANy4Ox/h
	AGec=
X-Received: by 2002:a05:600c:3ba2:b0:493:aa0a:45ad with SMTP id 5b1f17b1804b1-4994e794edamr191371065e9.2.1786025530351;
        Thu, 06 Aug 2026 07:12:10 -0700 (PDT)
X-Received: by 2002:a05:600c:3ba2:b0:493:aa0a:45ad with SMTP id 5b1f17b1804b1-4994e794edamr191369505e9.2.1786025529693;
        Thu, 06 Aug 2026 07:12:09 -0700 (PDT)
Received: from sgarzare-redhat ([5.77.117.129])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49952dda992sm35827965e9.2.2026.08.06.07.12.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 07:12:09 -0700 (PDT)
Date: Thu, 6 Aug 2026 16:12:03 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Sean Christopherson <seanjc@google.com>
Cc: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, mst@redhat.com, stefanha@redhat.com, jasowangio@gmail.com, 
	eperezma@redhat.com
Subject: Re: [PATCH] vhost: clear vq->worker under vq->mutex when freeing
 workers
Message-ID: <anSV9yFUHLubu7v4@sgarzare-redhat>
References: <20260723153310.745855-1-andrey.drobyshev@virtuozzo.com>
 <anSMBpQJ8x-vXYy2@sgarzare-redhat>
 <anSRyFTNGC-XcFM1@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <anSRyFTNGC-XcFM1@google.com>

On Thu, Aug 06, 2026 at 06:53:12AM -0700, Sean Christopherson wrote:
>On Thu, Aug 06, 2026, Stefano Garzarella wrote:
>> On Thu, Jul 23, 2026 at 06:33:10PM +0300, Andrey Drobyshev wrote:
>> > The effect is harmless in practice, as this only happens while the
>> > owning process (and thus the whole device) is dying, but the lockless
>> > write is inconsistent with the rest of the code.  Clear vq->worker under
>> > vq->mutex, like everyone else, so that all writers of vq->worker follow
>> > the same locking rule.
>> >
>> > This issue was found by Sashiko AI review.
>>
>> Can you share a link to the review?
>>
>> I don't know if it's common or not, but having the link in the commit or
>> after --- will help the reviewers.
>
>+1.  FWIW, I've been using and encouraging the "standard" Reported-by+Closes, e.g.
>
>    Reported-by: Sashiko Bot <sashiko-bot@kernel.org>
>    Closes: https://lore.kernel.org/all/20260625212001.3B6561F000E9@smtp.kernel.org
>

Yeah, this makes a lot of sense to me! I'll encourage the same.

Thanks,
Stefano

