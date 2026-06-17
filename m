Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 176AE3002A0
	for <netdev@vger.kernel.org>; Wed, 17 Jun 2026 04:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781669028; cv=pass; b=s8IvlC2pHFKlR5xTepJNgG02ZSSmzsMi6/Eo7OTXSU6/8klhHA89xjsf7eQKnhppM932CnuYZZGI2ftXZY5WRFImhdQBveOT1iLwsxjNI59M1SQSTb3Ii+R7Yk+GvczRVDimJw3sjGH1gIIBHCPgcPq9O/F89+GvQl+u7Y881jk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781669028; c=relaxed/simple;
	bh=nGDDKPMF7cvXoB7/DDIKRcLBkAO/e6gijUwIyJErKRI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BQDMRrw+1+SuDF9Jj58v1clUYBw+Q6h6fKZTwDSGbpfCBR8H2ykA6D6J5lSzC9HbhiAKIiDPmKGuaSdppuAbNmg/nNBQO50BIYn1NUkE76dBivUA53Z/O+Dn+vzBKF2vjVBD210/VQOaYCGxJ7jRU+yYMiMFw8Ig2qbD52E6GDY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=K7hGd8/P; arc=pass smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K7hGd8/P"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-517654b8e28so38405491cf.3
        for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 21:03:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781669026; cv=none;
        d=google.com; s=arc-20240605;
        b=i3LZHQeP5WRP92Skfh3hlg0bRQ7XSArYoUyixWrPLBDwLcCasZO90cWszPXn/6eLuY
         ut7vcctjSnxL5U9NPHKJRjO9v8Layytx12VQKBqxPuxrDspCam/66cGajhJrYe3V0vMz
         IGdYLTvtNfknOX/Te9Gp5tdqxnn3r4kVrHFUjw87e7UAnAayg177OfJ8M4YAfq5Q7iAr
         dWLVV9heQ+JQdRymg44wIWVY/cvzTfXUxXNpsdUyXgPu9csLS6M1TL8ZHyiZHPwW80lS
         Ulzhz8lQtf4i9Yo8N0+m0hTCWbiwPk51HsLVTHvPqqkL2s6IcvuzncCxTmsbJYgB1VRw
         3dHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=R8KyfV9Pt06ZHHcC1zYd9eBjxY7fk7AzCnkPLQzY7i8=;
        fh=HO0o4YaoBze70NIioEojEyGKkCbQrzJ5A2b2LeFiBTw=;
        b=I3IwrMC0fZ5Nibt6SK3LTb7s2HMxUf7z0lkA4xpWUL3MJBWBRoqpSaE1BSxLU+jpdQ
         ZHVuCDm3nxI4qlF+pHjpZeQOBv4HtJ7dRvCvuwQNCTOg8s4ay++xND07XQ8CXzrdATQB
         lAc/YTqP1xSbdP9jYGp2rZQO6584ly05PV38MHNQBpdnfaNZ6Pt3oFJtrwHg+c1Udc8L
         7xe/nYpiHqzP1opguHHP3Go0d9/8bndPolRzVS1UMtG/TbXu6e/7iEX/4JmJhI1wVWBO
         lo/zS/4p6yUhs18XAe6BoslEYdwhvoyZbBJ2yU1exU7XCNdsxMrI3Sfn3sa+6OQtKagY
         wpBQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781669026; x=1782273826; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R8KyfV9Pt06ZHHcC1zYd9eBjxY7fk7AzCnkPLQzY7i8=;
        b=K7hGd8/PCloNkTaoacnaHuFi3QJf+E/64nTHm70zK8Cw/TePNpSkfC14TqaOyu5Q0H
         mT0AhyNAhWOSS7wrM6HThj8bmrEr6HVGhL5Ne+MV5ANQrctcKVIyVuDw1G7XVVxjdBzS
         dGoKE7Bn5ug8s+Y7cUMcwPdir7VmmYY7pg67rkKWbi1+Fdh3ic6RKulFinIKqJGz3UAK
         SzDo1aHnbhu6vpiUWxFnl9THNuyVSosQNgxU+21+IQN0QDXxy2VNZTvAmNQC92CO6tH7
         PqtxhqOshiE+4C6Z0897fwC3+nqRUWnzeUs8cefRPWgR6O1ntdjex8xN9pYNaMZJiV7k
         1Aiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781669026; x=1782273826;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=R8KyfV9Pt06ZHHcC1zYd9eBjxY7fk7AzCnkPLQzY7i8=;
        b=q3x+EcEjZhaoIbnGsqDH28Jo+sHQ1hCHLtMH/gZJFGToIcux+wxXT15uHBzvGVZY5z
         QKuwKu05NdnnwrkJupiSC9UXQnw/T0bFzFJ48vq7RiO4ScnOafgxKNzU/fMPcAvvFVrk
         9yT/18ijNlTDoRo7SLfTdfsrLipGfvNFrsteleLWWbBPFrFRMVHDZNsxYLjQXwETPD/U
         avDT3rWXzXwDdoxhOyrabcqa7WP6v7CDSkKiqa8E4KLfmWmIyWaRJ0ssR9XgCSgQkp4k
         +aUQLtv5G+lS8JmZJZ+C9YiNR8t6eTCvuHyWsbhAemPzAQF+ZT7GZT166pV30a5Ce3Rx
         L3PA==
X-Gm-Message-State: AOJu0YyRga3l30qTg98l1Z6xGyL08eyfrn5Kfdpb/5cIJozn7qmWmQlt
	lSh2xstklveq2qKWI9h/QRdQkq1LlE9HHTg2Rf2R8ViILuskD69K3jhriO10SQsdBhA9nfqYIpu
	d7tyV6axlpxvjQWZHgvaw4fOwqlFhLmjcdN0gIThO
X-Gm-Gg: Acq92OE1iA+GO1oOYmeGeWXWCIzbRRwkHARundWthpnCtv0ulsOSimhg68ngUEMkcov
	Bni8PZJ0Fy4ELFK11M8Ujr9Ipkr751n2rcn/Rp0uDDnAUObUKVIpOVOU9QId6MVBue4hPiUECkI
	qJPOzYmwZAdillz3kI7Gi16hCgVr2tVnTrq9bwMQzSytus8haCxNtnYEFcRgYGLVwuXpzAf7ru2
	Zf0USl41Yc45wpZbknmza/zrs7pbvqSuihVoRtXdkowm9fE6YN2xZ3bTuEJtnvcF+UdiEadjZtG
	/dRUPk/nf72NZEf9VzFU7nF++4DRH++fCy/SNBlF0VRElWu0VVGGJHf3iysC7G8Q7XsvWIQQKWN
	i12GyCVSD
X-Received: by 2002:a05:622a:a6ca:b0:517:6c6f:8ee6 with SMTP id
 d75a77b69052e-519a8c6908fmr36262241cf.6.1781669025646; Tue, 16 Jun 2026
 21:03:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260617013208.3781453-1-joshwash@google.com>
In-Reply-To: <20260617013208.3781453-1-joshwash@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 16 Jun 2026 21:03:33 -0700
X-Gm-Features: AVVi8CesugWGvhT1ob5SAVvgc8BH84Ip7FIlMibVTmgvAH_bFYwrk6DEdOErY80
Message-ID: <CANn89iLoYFW+TLt02c_sUtXcPL3-ONiQjFxqaA4BSsRCoAd_zA@mail.gmail.com>
Subject: Re: [PATCH net] gve: fix header buffer corruption with header-split
 and HW-GRO
To: Joshua Washington <joshwash@google.com>
Cc: netdev@vger.kernel.org, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, Tim Hostetler <thostet@google.com>, 
	Ziwei Xiao <ziweixiao@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>, 
	Jeroen de Borst <jeroendb@google.com>, linux-kernel@vger.kernel.org, 
	Ankit Garg <nktgrg@google.com>, stable@vger.kernel.org, 
	Jordan Rhee <jordanrhee@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 16, 2026 at 6:32=E2=80=AFPM Joshua Washington <joshwash@google.=
com> wrote:
>
> From: Ankit Garg <nktgrg@google.com>
>
> The DQO RX datapath programs a per-buffer-queue-descriptor
> header_buf_addr at post time and reads the split header back at
> completion time. Both the post and the read currently index the
> header buffer by queue position rather than by the buffer's identity:
>
>   - post (gve_rx_post_buffers_dqo): header_buf_addr is computed from
>     bufq->tail
>   - read (gve_rx_dqo): the header is read from desc_idx (the completion
>     queue head index)
>
...

> Cc: stable@vger.kernel.org
> Fixes: 5e37d8254e7f ("gve: Add header split data path")
> Signed-off-by: Ankit Garg <nktgrg@google.com>
> Reviewed-by: Praveen Kaligineedi <pkaligineedi@google.com>
> Reviewed-by: Jordan Rhee <jordanrhee@google.com>
> Reviewed-by: Harshitha Ramamurthy <hramamurthy@google.com>
> Signed-off-by: Joshua Washington <joshwash@google.com>
> ---

Reviewed-by: Eric Dumazet <edumazet@google.com>
