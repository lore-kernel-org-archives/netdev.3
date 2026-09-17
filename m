Received: from mail-wm2-f4.google.com (mail-wm2-f4.google.com [74.125.225.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20DDD3D9041
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 11:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789644018; cv=none; b=qo+Bg455CkSBepXNMnjXICDQiH785HqrdmmiOpKwXDmw4U+SyyA7DYZZJVdA/7hnQwPhw5/UVEsvnbUaTFmMbp3hLZ/elbGk7Ehht3X/jsEeNjYoH5GTsF18oQe/O7GS1HiT3neyl0RQrq5UW8YaV4IaxCEjREPfSxJuCRQzQg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789644018; c=relaxed/simple;
	bh=LlxGdMXHAdX8taCMIhqIXD7uLIJKX+ph9Ruyy3ooAaI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=WYwQobrIo/sNKTRnMTP/9DQ6C1Cm2CHjmLF4BOpo2GMz4HHFvFMuoa/OqniHjwjBdEbM7l5fKEo6fpgu7ybugeBb5G/AEapwfEIhBz0a2MDdBIVFkniDmq6VO1ZiPiyWhkFypxv+egIwBlA+6bdAU9bbzs332MP3HAIL3F/iKmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ujon/4u9; arc=none smtp.client-ip=74.125.225.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ujon/4u9"
Received: by mail-wm2-f4.google.com with SMTP id 5b1f17b1804b1-49cd71f9909so927125e9.1
        for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 04:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789644012; x=1790248812; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=+g+yvkGeEUlWNyJpsteUjFqXg2BUoy498hjd0wgzrh4=;
        b=Ujon/4u93dRla03uTYoS2izgIrqQkjHxlou7MTB/wEAzr+IzPSODRlWF2nWRYoKb+m
         fOgZbYgYv/oPcAy0mzvyti63Fm2nehNlvrXH6QT4w6d0ozwKAqto+SJQCPSHkOtWwZXP
         W6W3UMO+OxZG8MdLwNmokiL7mJZrJihJU7yL8mQT0WVc/UELvxRduWNXQQtEyG8ATpyC
         oQ/nmG3lBkjrL4RdMtvIjnM6eKvus1otUnPmJWldGLAPtDhD4/vEND4KK3Cgsx4IJcIe
         rArFOHE3zZVRZuuVtxXuW6uc5ZJinTFrMkAFa8JR4Qu55PlPVXogGWKPK75nJuITGTay
         RaVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789644012; x=1790248812;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+g+yvkGeEUlWNyJpsteUjFqXg2BUoy498hjd0wgzrh4=;
        b=tNFZ6xNp+i9nDRdA3SrCcjDsl1srP+1ZLauyMW2TzEZHQM89IZ0pvuqdCtD0xGfvxC
         EV25Z8wWrxoUQMe1U7wh6OO6x02EN1g7WCLYSdExPMouE2I36Ft8sB2Ph94jhtxx71xz
         bSozaaP33oran2dZgfUgL4F7212o0o7z6qZgI7bS9rJ6Gk0dQ+cdEXn19GUayGnPwn6N
         8WnAF98aAfX71eos3macm6vCdFq/XtcUk3krXXv2romzYqTw7ksMJlfLeuG6o1QsXC+v
         iVRy20+M7bCpQZoBJtx6dYeWZCCucCh6c+cZ6b7iPUEDLrQDSl4dCJMxmlNn0zA4i77U
         1GKw==
X-Forwarded-Encrypted: i=1; AKwUvBzqVq+JzguJLl75cTlrmXy3bi2S4u041P/UQrpLb3Ep+0fSDdYbal2BTri4CYKr1pD1w8/I6VY=@vger.kernel.org
X-Gm-Message-State: AFuF++n8b5i/dN3XZJLc849J7oN1NbR84l9+3JeTo1GKFsZGThrSMA9I
	xZnNRYBHBsvZktKpu9lDkt+38xRJmyeUqJxEpCUmTYZbsP8RnkMqZHPD
X-Gm-Gg: AYBFou1zpHa2arHfOdBvl0206mbucKIrCX96tip7+dp87F+bNKCOkoD3A7ET3aU9OQK
	hzSE79VomKd76gCRDm7VffpG3IhFxCZ8LsK8xiMskgF18jERqqWtwF3kXzZ7v8hUUTuCytv9iu7
	LA+KbWLqWsfDq/Pu8fi+KojBEBkvUvW03m+cjFXVlvzqLvGA0051bJeF8KEyZwmEpXO5GxFqUoL
	1R8+R8qs4vuQz1wvN4JIU44wOgGW5nTUuUsFfH5nKq3G4xE+k11qLayEMCa6FFf8QND0aKjDe/2
	7ZJfmnaBJx2r41hN+ZyfuV6iZcSn4RIlD85Xt7Gz61JZf4ObmwcbDukOTh6uPKacU19Xb3ckuXu
	XdYiFCa+EI4SfKSz/7wKni+OiT/3lYfEtdK9KVmsXC5H7jev0XZefsnnbx6m8DO/8fUGO0cSKJO
	BBBQWTkSFokAm2vW33YfFBLbj6uwzL3F7Lf/2SYnKJrAWXwyhzNksHrpDuR8+XqHwBAon+1rkKO
	xrj4UDJ2RdZCtNMB9brVfO19OkSyk2gQe3nNgX2Hm06H7U/4xIM4KRaq25uGf2zHiuTAcQ29joc
	KdLZPyienKn5Fj0L6L/FK3BeDGKWDcUoRAJHsbM=
X-Received: by 2002:a05:600c:620d:b0:49e:6692:27fd with SMTP id 5b1f17b1804b1-49eac46430amr164310975e9.2.1789644012140;
        Thu, 17 Sep 2026 04:20:12 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fbd23f4e6sm80589305e9.8.2026.09.17.04.20.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Sep 2026 04:20:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 17 Sep 2026 13:20:11 +0200
Message-Id: <DLHJUSTDSQ05.28VUGOV7YPS6V@gmail.com>
Subject: Re: Missing signoff in the bpf tree
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: "Mark Brown" <broonie@kernel.org>
Cc: "Daniel Borkmann" <daniel@iogearbox.net>, "Alexei Starovoitov"
 <ast@kernel.org>, "Andrii Nakryiko" <andrii@kernel.org>, "bpf"
 <bpf@vger.kernel.org>, "Networking" <netdev@vger.kernel.org>, "Eduard
 Zingerman" <eddyz87@gmail.com>, <linux-kernel@vger.kernel.org>,
 <linux-next@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <aqvBPVcN__UX8P85@sirena.org.uk>
 <DLHJEZ0K0FV1.SCQLJJQNS1ES@gmail.com>
 <66d3f5cd-12df-4000-8459-360ba57cea12@sirena.org.uk>
In-Reply-To: <66d3f5cd-12df-4000-8459-360ba57cea12@sirena.org.uk>

On Thu Sep 17, 2026 at 1:09 PM CEST, Mark Brown wrote:
> On Thu, Sep 17, 2026 at 12:59:30PM +0200, Kumar Kartikeya Dwivedi wrote:
>> +To Eduard
>>
>> On Thu Sep 17, 2026 at 12:30 PM CEST, Mark Brown wrote:
>> > Commits
>> >
>> >   4499609f99fd5 ("selftests/bpf: Test global subprog callback contexts=
")
>> >   3506b9a2f1085 ("bpf: Verify global subprogs in each sleepability con=
text")
>> >
>> > are missing a Signed-off-by from their committers
>
> Does the contacts list for the BPF trees need to be updated?

Well, he's the committer, so makes sense to put him in the recipients as we=
ll :).
Once he gets to this he can probably force push to correct it, I guess.
