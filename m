Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1824AB1A9
	for <netdev@vger.kernel.org>; Mon,  5 Oct 2026 14:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791212051; cv=pass; b=E8x1PawaCBhAxfwVVDAGa5um9It46wQhcp+nQHSu18XnZ8QysyKPMqawmDVtndqjM1CeMjwE5QkEl4jQx7YlSSjhRSs/BtRQCR+QLzM/gqEnQQL/fLx/Zjn0+vUB//ZLNovBXEQosHE/wSuT5LuNwR64XCy5rYZiaXkDg5nHHoA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791212051; c=relaxed/simple;
	bh=8zZ8QYcbf7PQFHGj3s4MFHZ/+0IN7ifpAJMj58pWUE8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dkeycYrZfiIZ9VkyQq2vAVX36v2wgp9dEjWr/SRsZwYEFHqBoePMyRlkZbP7KgTbxUH1RTfrvu2A+C8SuROHEpu13DfUSlQGTatteAdjue7VkERrznSCSYJUiSyzTLMfIkgUbzqW2QeKRu0tK2MYdVPJ8R5vYXyGnz4MKpMLlRY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UNCs36qR; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=KlGEzdkk; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UNCs36qR";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="KlGEzdkk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791212041;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8zZ8QYcbf7PQFHGj3s4MFHZ/+0IN7ifpAJMj58pWUE8=;
	b=UNCs36qRvMqrJk+fUE7/slQpMCm6uQzuzt6+booX6SZy+TvPWd2yIbV0ymHfVOZ7BGP98O
	ofDBF5kbttDo00oplATBLOBHj1HtCJt6n63mD/f6Qf7v0iDkgYjwzDi14d4hN+NPZ+rXa0
	IeTsFlohHwNea6BpBB7KlKyQv7WsnkA=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-568-gO_-zRFSOMq8UkbyVGVMFQ-1; Mon, 05 Oct 2026 10:53:52 -0400
X-MC-Unique: gO_-zRFSOMq8UkbyVGVMFQ-1
X-Mimecast-MFC-AGG-ID: gO_-zRFSOMq8UkbyVGVMFQ_1791212028
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-3a87341f090so10998871fa.3
        for <netdev@vger.kernel.org>; Mon, 05 Oct 2026 07:53:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791212028; cv=none;
        d=google.com; s=arc-20260327;
        b=FWuy7a72qgiXUSiOhzHDpL/AnqNFxi1dc1r1eYWxNvAdpeAiokGR3/jWXEw+lm1Kto
         fw+ei0bsxTMBHMfEwvsGu5FHx4eoOvCmsUNz40I1sGJX49Xpo6ejvsetbf5vO8KxMAoY
         74E6+4WVddKyxh2ZqZVvMQTk+bErOqdVjUrybxUA2ygRmevt0W9gX/+V+6BCFPQS7dck
         BXGGB4YrlmDUtHTwHF8+KpUOnp36J6D8U2ISs/WGl4tQgXy9R3mFg7TJKqdvlWaLzdUO
         UXtY0jFI1L/1/D8H6MEVTKNRTX5SrJ+h9DZU8cri0AeG+emNjh5abw67xOnuEO85wnBd
         hUAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8zZ8QYcbf7PQFHGj3s4MFHZ/+0IN7ifpAJMj58pWUE8=;
        fh=gM0eV9MPCr5FyTNVdJJWb3HfykgxQzTtrhMo2Ixsft0=;
        b=hg49iyJ3QxDqozNCsU8tdMlp9bKg9+Jj9TIyHb+bey2mUopc1pjaS6CXHK5n2EJBPs
         VZ97S+YiS4MVOgf+wr+zJWxhfwdRca3TBZ69GotI+JMzOSMRapGGgV4HoBetoqFJI8Pa
         svDXModorZXXtL09ATYv8r9JaNkUwciKLeoMusXTj6cvi+S+L7GQ5dXMrXTkBpqClDf8
         +D0IxolIkWDsfTKNFzmUOQ5e8QPgOBoa0yi9Cn2eOy8wJgO0bMMw2CGT/ezTtV70V5hj
         5FZZiK7xqZ4GRI0af3HE/JwkJp/fTsZbZrsOJqMJOYlRSl37vSqusWu+zryZQpPBlv9D
         PlYw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1791212028; x=1791816828; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8zZ8QYcbf7PQFHGj3s4MFHZ/+0IN7ifpAJMj58pWUE8=;
        b=KlGEzdkkmENR0bcKZmM4tW31XfH+ppwyLOfYmgZal3AZ++NCX3ONX63g5bY38o3dim
         Uc7Ip+hoI4HnYlU0wUaCMRhyJgdgZxYLMFVO4uawEFRznS/a6jW1BFmDCfhpk4qDfhKK
         5cy4Utj2SpJvWfRl6q6mMaFFpAdU+dL7MpwF3HZ8Yofqy91/pH0NHwZobfJuj4jqJsaH
         /A8LZinQvvtCLefNPnoZLKHNoLMORYRCPMdZE8TpjxZxkBKVG94+6IVr5aqTmINhOrJV
         5qmKFxFdajSThs7/E/x79v1XU+K0w1NV5cTSFHnwz0Ja2Wk5xhW4DCXwfX1EX8x9u1R+
         LIsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791212028; x=1791816828;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8zZ8QYcbf7PQFHGj3s4MFHZ/+0IN7ifpAJMj58pWUE8=;
        b=UrajUvedq++m2IC9H9BBnf09vtA0XGpeQhQWCuDIULYVOQGt9QbLqhQ6wO8rmLBBt9
         qdQoRIIwWcrE9NFuLOeA09zfzZ9BoN03DBnVxDVF00stj4HTQB8HiZJmsX8qM5fGf4hu
         2QJtcPoVYZNN1aebjRnO+20Xix2RhUOd5I0H9GW+7IEb4LuFmCe6p3gzfTxP6IhBspRf
         ZwKvY2e7hqBbkdc31dVPA1U93ErQ89k5pbnRbPFcBzFz6z4X67N86aWDRH0XPrZVepmm
         qH+Ag/SI+L4XWOW9LcOaBKJhlEhv8OQ1rOCJNIqcXHNsnXGzjMYTNsYhafQZSNWrpyL6
         ZdZA==
X-Forwarded-Encrypted: i=1; AKwUvByiUz5KJBx+lRyYoduRrseB34MPRNehpHZLEauYAN5V99JASHFEYxab7EXkAO1KgYLGpdYB16U=@vger.kernel.org
X-Gm-Message-State: AFq9FYItHsajO8N3fmk1CdphEGmjAnLiJF7HUB904vAByBc2cQc5mkw8
	fu7ti6YIAjPIh04WG76PYZsFY84cDHuch8tNVV3zOMtu/4h67kUdIyw3aUcMBAtXxhUMv5Fhl+/
	1h8zp6iM5Pi8P9ygvmf5O3S3koEkjDrSox4yyxSbrBvIijtvr8+SgRmoZQllA7U34Zv6voR0idi
	ggB7bIybqJj/Dpmv8k5Xo9pjwM9DOw95Q/
X-Gm-Gg: AYBFou0+QRfil9F0Rb2qWhd2dYzMvBFklasYtQC9Ulb+XEfN/G1b6d2x+su5QOGlMz+
	pza9y0Z796+DiuFGRwo8A3uE7oUlPzmLXqyXfOopRMbTTbyBydZzIoqyqguKNVTq/xN9Bmn2IIu
	QQkyNfUlAJgUh0ILIV2+q+oHHs8BH0jyE2fKUsgZSGEflZns094oXqiUAX
X-Received: by 2002:a05:651c:a214:10b0:3a6:58fb:8540 with SMTP id 38308e7fff4ca-3a8877acfdbmr19316401fa.19.1791212028013;
        Mon, 05 Oct 2026 07:53:48 -0700 (PDT)
X-Received: by 2002:a05:651c:a214:10b0:3a6:58fb:8540 with SMTP id
 38308e7fff4ca-3a8877acfdbmr19316311fa.19.1791212027578; Mon, 05 Oct 2026
 07:53:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261002232107.1578646-1-aahringo@redhat.com> <20261002232107.1578646-3-aahringo@redhat.com>
In-Reply-To: <20261002232107.1578646-3-aahringo@redhat.com>
From: Alexander Aring <aahringo@redhat.com>
Date: Mon, 5 Oct 2026 10:53:36 -0400
X-Gm-Features: AclHuK-ouLvX0-7cuNCKJafhkt9kjj0OqJOrCqwFlOBX9-Z-Ur5EBRc5Gfep-CY
Message-ID: <CAK-6q+i7ix55=aJ0hRHHq-V+YNym-VQ4dKVc0KpWzGP-BLXTwA@mail.gmail.com>
Subject: Re: [RFC 2/2] dlm: fix socket hang on send buffer limitation with
 socket error
To: edumazet@kernel.org
Cc: gfs2@lists.linux.dev, netdev@vger.kernel.org, davem@davemloft.net, 
	kuba@kernel.org, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Oct 2, 2026 at 7:21=E2=80=AFPM Alexander Aring <aahringo@redhat.com=
> wrote:
>
> As Sashiko AI bot mentioned [0], a socket connection can get stuck when
> the send buffer limitation is reached and a socket error simultaneously
> occurs.
>
> This issue can be reproduced with the following setup:
> 1. Set sk_sndbuf to SOCK_MIN_SNDBUF.
> 2. Slow down DLM connections using netem.
> 3. Use tcpkill to randomly send TCP resets to DLM connections.

I ran this over the weekend and wasn't able to get the connection to
get stuck in the mentioned scenario as I think it triggers
.sk_write_space() and .sk_error_report() interleaved randomly.

- Alex

