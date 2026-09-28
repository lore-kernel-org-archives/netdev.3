Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE6743009CB
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 15:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790607661; cv=none; b=CZ/trVNreO4SwDYMOlblvF0P0Rx0zkSh0FmvYCysOkEyTzDF944+p2YHtoluOKN+L3i0Kw+aECA7D31obryr6qGl6hxLfn28uNI9lJHBVepWzWTQpbH417Mo9Ex+2cLKyDcM/tBt/g+qvacyK9dGpRir8eSW2O5oQ4vhpD/XsBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790607661; c=relaxed/simple;
	bh=nGJsllp8L7sqYAKIQ2/Hr/XmIXmSD+YY1xB0lRGMVQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xab38WZtmNcNO67IlkJyoABVHPEQOspDMMtUe71X+d4z2vwYZz5kjJXe41b3LX6f0Og66QIfSggJtSDd/OAghedcKOaxNDsiIRNhj+/dzKoTrOmQDF3vPlj8gm77Jb4C/Day+JFYSE9yfAqzaiEb9uvrbDeLy9ylPl/CKkjMS+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZRJnRYmv; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=EelShbUI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZRJnRYmv";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="EelShbUI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790607657;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vKOeRv5jdbU0/NaEiGEDb5uvk7fcRI56Q4PTcfyI8cI=;
	b=ZRJnRYmvJIgmNYKaS56eP57E+EYRgVEY+VJHGCpRgk0n5buTmwneJfe2IUFCVLhccSrHhl
	9kh+Zm+ouCdLWwNCKR0Nyft83FMB3kaaXhDsy4RBx0lK6grQ+R0dtIwC4bKjz02F4q3He8
	T2PaoXx8PUp8OH6bKOuk+3Vz7Qy23Lg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-258-TnPzXXJ4MVidM2WB_w8G0A-1; Mon, 28 Sep 2026 11:00:56 -0400
X-MC-Unique: TnPzXXJ4MVidM2WB_w8G0A-1
X-Mimecast-MFC-AGG-ID: TnPzXXJ4MVidM2WB_w8G0A_1790607654
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-49e635a6002so38217875e9.0
        for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 08:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1790607654; x=1791212454; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vKOeRv5jdbU0/NaEiGEDb5uvk7fcRI56Q4PTcfyI8cI=;
        b=EelShbUIxOpADeI2YrBW6+G/e7eqp/RtYA5pyAuMl1Lowv2yTEe3K0xBqvDlAp5wQO
         soNEbbdtyf/aiPGsVeAn7BIXFJCTongbAlgYSFJ9OsF+MlhS3qcYXWFXV9c06f+pru3O
         ADKH0mJFSn6xxOhaza909Klz8D2qrBpDLLSy7Dg99hYcDzZIGkK8mxH+1GInHqi+0wtl
         j8xbWEHWYEIuYhTJNUSgZPlxpCzCf3+RsNd00/0tQa/yyMK5IQNFxi3UMNTNdiVdFVZa
         zlcUwT5QLpI5wvOl9V9wq4AJ/OzU278j4yvG6KrPILe5ojsSWCeWqiBaj4MsNeFqu+Zp
         7C2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790607654; x=1791212454;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vKOeRv5jdbU0/NaEiGEDb5uvk7fcRI56Q4PTcfyI8cI=;
        b=Qu3rDuF/ad1N58jFmU8L7HRYlwmgdFPlDPqQiBH2ioYVNzxSTKo2xwcK1vFBQd/dyK
         Z7nW7ZvEY9KhwBeW1fnQQGvQLpun3z7BprXtqy0t4RvoP25P1YlIFYmMOGkMqXDtlT0n
         hL5lbYnGSetQ1nQMzQImQayLt+h6YZ8t4oH2JTCwy0uimrVxFL6DS9o9XJBa1cnzWWD7
         d2PWSghI3rGxrBbtL/VihlfACBmDQTHQJ6uKmJBkJ0bCn6sauXMd+ef7xCjuDxB5wAld
         uHorGJ3f3VpKikT1ABmDZgXcOYGF3cN9WSyitNLHPEiNHZZpuyR8pjmYGYwVozcPiW+7
         OBOQ==
X-Gm-Message-State: AFuF++lNg5nSxWgXn0j7rslcJ7lxHSzNS3zz+otgfKTqWNBZXNa9ELpo
	rbCGnWIrOH9LWwh3bmhDzMiAZNGC+/ucjavnYnaFG7rqNPK7rt24kN6iOc9KwO0g+jGbIFguMTi
	51WTKQffgIHra+nHIQRelQUdy9YE91RjPrtYiteKxxs/hQEEyj8AvRryqZQ==
X-Gm-Gg: AYBFou38hMeXGbrjUSb7IIqGoF71cAIAHeNLv2RUgq+WrIThdByrFMnlFkSjhg35x+T
	FkYEb5vKjYx4o83u8k9HysTKkyqNTEVzMhrEhClShjTY89D+Tmn+69slAm98VwoI2IbIoGGCGYY
	LjOustg44jszmYY/dZp0B0B8sLsdqchiu8hjb7cbC5lQ9+G2vBmMruVwnXMb+PobVplyE+lxQf4
	SuHALKZTmR/mmkNV5zdC2hu6N3n9h9HSmgQfYcpJxRq6ChDxgfMfUM7rv28yQprkomaamzvJlWi
	uBl8F9pUOspkYSkgTXGcgQD7PrpHEwUMyWAe+kh2ncOjDgkQLiKspIfPwDkW/6VQJW2UaA3kc80
	9MXc=
X-Received: by 2002:a05:600c:46c6:b0:49f:fe88:e7d1 with SMTP id 5b1f17b1804b1-49ffe88e87dmr94651135e9.15.1790607652033;
        Mon, 28 Sep 2026 08:00:52 -0700 (PDT)
X-Received: by 2002:a05:600c:46c6:b0:49f:fe88:e7d1 with SMTP id 5b1f17b1804b1-49ffe88e87dmr94649615e9.15.1790607650593;
        Mon, 28 Sep 2026 08:00:50 -0700 (PDT)
Received: from sgarzare-redhat ([5.179.146.191])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a001922102sm151770215e9.15.2026.09.28.08.00.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 08:00:49 -0700 (PDT)
Date: Mon, 28 Sep 2026 17:00:47 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: David Carlier <devnexen@gmail.com>
Cc: netdev@vger.kernel.org, bobbyeshleman@gmail.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/2] vsock/test: cover receive queue hints
Message-ID: <arqBCldsgfzf1nUW@sgarzare-redhat>
References: <20260923184008.153541-1-devnexen@gmail.com>
 <20260923184008.153541-3-devnexen@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260923184008.153541-3-devnexen@gmail.com>

On Wed, Sep 23, 2026 at 07:40:08PM +0100, David Carlier wrote:
> Add io_uring receive tests checking IORING_CQE_F_SOCK_NONEMPTY across a
> partial receive, draining while the peer stays connected, EOF, a
> nonblocking receive on an empty queue, a zero-length request, and a
> multishot receive with provided buffers.
> 
> Signed-off-by: David Carlier <devnexen@gmail.com>
> ---
>  tools/testing/vsock/util.c             |   9 +
>  tools/testing/vsock/util.h             |   1 +
>  tools/testing/vsock/vsock_uring_test.c | 391 +++++++++++++++++++++++++
>  3 files changed, 401 insertions(+)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

