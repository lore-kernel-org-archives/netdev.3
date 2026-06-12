Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7261C3A48E6
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 10:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781260887; cv=none; b=VapdLc9bzdSqwsOX9u9CsQ7qk/LyfpkpklRFj0vD/fWVUJXsdgEH98zkF+h/FxpN4/cUV8VXYYkpO87x9NMmT9+CNQoeqB1uzqD78IQf5bRv1OCv8iicIj5LszfpCAQ7jeiwPoLhsBeFDGhCcaNNn+ETJJogw91+bVmry1kUCNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781260887; c=relaxed/simple;
	bh=5rn91acBsm08u48pralh41ZJgakPaI+PEvZtOgQ92sE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o90qaMJEP3wlxfGCmn1PTpHlNlpt7NtrmRfFNwnhcekswOT9bgJCH/iShtVYElJQjkItd+otq4v+NymOCk4F/qczpyxqnb+QaUsbl5qlCyaXj/oIpuDqMpJ5apO1/uclR5OYbAsLsuQKQ8hk1Zl99jJ56rPVLhwgr4mOHnXiWGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O0IrGygV; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=MVOCA+5x; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O0IrGygV";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="MVOCA+5x"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781260883;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xu4LvRoaZhXPB8pYhXmsm0zVQACpffE7HNmCn1yjRzE=;
	b=O0IrGygVmYEqqi3sT3bTUvJwT2STsGxzvpGE899qWgTSRp8djuM3A3awAfYGptVP9/zsok
	CcycSYs8S5fNDYDAEaJhAxW3ZtMcZ+uGBVv9pTzFEiMUf6j/kgr1oyFJlwU3L5utgH1H1E
	5tIYOztgAa0vCPKQ/pRBnhpoX2zjJP8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-488-alkSOLQPM1CFa2liwAxWsQ-1; Fri, 12 Jun 2026 06:41:20 -0400
X-MC-Unique: alkSOLQPM1CFa2liwAxWsQ-1
X-Mimecast-MFC-AGG-ID: alkSOLQPM1CFa2liwAxWsQ_1781260879
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-45ef9437b7aso499107f8f.0
        for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 03:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1781260879; x=1781865679; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xu4LvRoaZhXPB8pYhXmsm0zVQACpffE7HNmCn1yjRzE=;
        b=MVOCA+5x3ksoxZkF7IhnoW9HWYtEJb90XEMn7eHGArFRd/2pZRLQvhlixCe8SU4RDZ
         b4PJn5oFm645T9gK3BTJgFurbOE5vS/eHo1RPUzbeRVJzoGaVs1aX9d6SibFahtuOdSm
         RPZduKi7hzQ99yKR3VeNLVeW663AEwVSGWUCsXktLu1ihfBHUVVkTWY9W2t7zr0PTwZP
         RF4onvvbtFyQkboUZxS6S77vFvF+kLd8P7lCszolYk5SNTc9VZPBrXFYTr+dgYv5R3sG
         yXqd+zr00fZaFo3J204qRe5c+vvML1B9o9ZmoGG/75wyiK+cRNpNHVWMko60kWq3UPH0
         UNmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781260879; x=1781865679;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xu4LvRoaZhXPB8pYhXmsm0zVQACpffE7HNmCn1yjRzE=;
        b=Y3uThG99n8o6kC6EfWmsuYcS8r3W+ytOaHHZkRyTIVjWaIJUo1xVMBS/PMO2YRGytk
         8pCN6IaMSehmVpNxKoM/K42IMB7WXLrKYjbYWFahUcuqLFJVuPhghiuxOOoabu5cykC9
         kV61q/9wKoyxPSKEH0uu++gQEOjq+gdMWPVMqCshwNPHLvcf3gVot0dfbvx04yH8hcLN
         eTex9dbZLLffjyDBwXpJnmsGkHUMx9A/Cm4GDxF37TmIzBDluJdHy9JG7UniKpm5B3WI
         XOxXUPUCHxTBc6s82N6o+0cjk1Qoa7ewJ58z4MhIaRbxBXJGSNlbhC3QBaLMkckrmuk2
         45xw==
X-Gm-Message-State: AOJu0YyE8Z5ObQ1pnpyd3rr9l5LTtFIBnmf7qur0RwQWYZYagLrQs1/7
	8khLE+UYyfz8RaiR43h+kkEF/FvzDK5BrsEVwF1ho6xyldJjVSzNWYgovMWPYMdEIhTAYtIoyGH
	+VNVOX2cOdfeWHbnQ5Tf7ihhmDAneLqstquZv0mcQEQe8bvLluDq//kM5QQ==
X-Gm-Gg: Acq92OEIWnW3QIHtif4brAYiTjflZXnjC/ltlqpV9uj+e3zKWp9CO9kNHK7bXMTU9Os
	8Jh245nVGVI8du+s26HfuKyr6HW67wmxzmJztwrIny0i6LidMFEuEb8xecd+OmBQCLe8oYXbXJm
	FpJJFZDv8lz02KdX09FoTXXx185EjNkuc3WRRLg/W8Bq0K9RDcvlNWPXIJzWdLZqQwsYbPTOmop
	FnDGqJv1lvekvhvx6r6CrXg/FROyqrG5Nkv6f7O+ZFqG+xnIz0r1e3Y7zdxP/5uCs/AG+QG9Dp9
	mAGWTAIXiFdRSYHpW7UD/r9KvmPWMopTf0EDTbHQtlhV4y7fS8NNZNyCHVCciPAt550lw7WIIC9
	CP1hlH3gnLhns7aX7rDXnJNnioioknoMSwNq3bcavO0Z8NV5Zp5HQF1NP/NzqfrvOPcJv5so=
X-Received: by 2002:a05:600c:1511:b0:490:ce99:d2ee with SMTP id 5b1f17b1804b1-490ec4df7b5mr15956435e9.15.1781260879099;
        Fri, 12 Jun 2026 03:41:19 -0700 (PDT)
X-Received: by 2002:a05:600c:1511:b0:490:ce99:d2ee with SMTP id 5b1f17b1804b1-490ec4df7b5mr15956155e9.15.1781260878658;
        Fri, 12 Jun 2026 03:41:18 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-135-12.retail.telecomitalia.it. [82.53.135.12])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490ea83d8dasm72684005e9.11.2026.06.12.03.41.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 03:41:18 -0700 (PDT)
Date: Fri, 12 Jun 2026 12:41:15 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Raf Dickson <rafdog35@gmail.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev, 
	pabeni@redhat.com, stefanha@redhat.com, bryan-bt.tan@broadcom.com, 
	vishnu.dasa@broadcom.com, bcm-kernel-feedback-list@broadcom.com, bobbyeshleman@gmail.com, 
	leonardi@redhat.com, horms@kernel.org, edumazet@google.com, kuba@kernel.org
Subject: Re: [PATCH net-next v3 1/4] vsock: introduce
 vsock_pending_to_accept() helper
Message-ID: <aiviO__2-a-1TZLC@sgarzare-redhat>
References: <20260612045216.105796-1-rafdog35@gmail.com>
 <20260612045216.105796-2-rafdog35@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260612045216.105796-2-rafdog35@gmail.com>

On Fri, Jun 12, 2026 at 04:52:13AM +0000, Raf Dickson wrote:
>Add vsock_pending_to_accept() to move a socket directly from the
>pending list to the accept queue in a single operation, avoiding
>the sock_put/sock_hold dance and the sk_acceptq_removed()/
>sk_acceptq_added() pair that would otherwise be needed when
>calling vsock_remove_pending() followed by vsock_enqueue_accept().
>
>Use it in vmci_transport_recv_connecting_server() where a completed
>handshake transitions the socket from pending to accept queue.
>
>Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
>Signed-off-by: Raf Dickson <rafdog35@gmail.com>
>---
> include/net/af_vsock.h         |  1 +
> net/vmw_vsock/af_vsock.c       | 10 ++++++++++
> net/vmw_vsock/vmci_transport.c |  3 +--
> 3 files changed, 12 insertions(+), 2 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

