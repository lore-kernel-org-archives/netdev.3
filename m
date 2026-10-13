Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48DCD4A8A12
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 06:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791872145; cv=none; b=P0H6jnAWhcQt+qlSzVZySe256gLWVxxGklDgEgCEWRZLJ7BELJF6GORCnAMmC/PEUQKoY4lJ7vk/O9BRuQcdjB4lYLiKvx1LdsNxugz3WBH9EvzdcY6UyVyK5+3vOaX8UpAGQUdpshMdPgYrBPa+b/hqSotU0ila8w9ZJNFrmJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791872145; c=relaxed/simple;
	bh=gkOs1wE0SFWtwXFO/wfDDZZI4cbWZXKezAxjpIUae8g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NGKHEfljSaw36+bIq+7IqvZA0qhS0RD5jiHCc4Xz9KxA7BsngyhTN5PVEfiftqMTxcfeK9S+Vbx4ja0mJ3VlecuavIvNTlrUUk55KKgZQOHu+rMWTEIOMX/Tgjwlrp1P3R0J87Dy1OmI1RU867+VZ/0rN8SidRH4UxFSvgflRm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JkAiboxz; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=uBxyjqmB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JkAiboxz";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="uBxyjqmB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791872143;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gkOs1wE0SFWtwXFO/wfDDZZI4cbWZXKezAxjpIUae8g=;
	b=JkAiboxz01lwnG0HM4QdzX6eunig86gfjVBbFThnqrhIMA/dLS2CTkgkSJKYZxUc6DL7/a
	pizJRk6zFlb8uy0ZdbfhBWQtnHlAF1/Z5Ekq67w5C69dO3dDHqH8mcA/eIuAcjPmMhX9g5
	XLNBx8KvOun48kD2Unl9Nv/eGtrzHXQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-99-nxeJnIFdNGCpG2ot5c0wNQ-1; Tue, 13 Oct 2026 06:15:41 +0000
X-MC-Unique: nxeJnIFdNGCpG2ot5c0wNQ-1
X-Mimecast-MFC-AGG-ID: nxeJnIFdNGCpG2ot5c0wNQ_1791872140
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4a19df2328cso21443905e9.3
        for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 23:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1791872140; x=1792476940; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gkOs1wE0SFWtwXFO/wfDDZZI4cbWZXKezAxjpIUae8g=;
        b=uBxyjqmB4bRq0mz9epC3t1ELX1mJTbOok0wOJBj5m3iGqw05b26sSuqvV08uNzrjmj
         tduHZt1XSDtFYJPeaR4S7w5QIYib4mJTxAepS9vSaATKL+DQrpjMNiE82IXshpP0JULu
         0+2xfyd79g2WntXwJUR+BCsqy01SolKFI0GumRjp3cWXOxyHFO7yzUL2UvxY5gCdG1sW
         GQlxDXMXC9CgaSqa+s0TxU7+OBFBGZ/lVafAI+rOSPP92zXkE8MBPS2CpEIkuFcXPltH
         0EaYYRVcAZMg32HYulRFm2It8otoqqfUhEZjxi+Ym5ZAasjLtwcjkAonfGrKDv9ThmHe
         rhyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791872140; x=1792476940;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gkOs1wE0SFWtwXFO/wfDDZZI4cbWZXKezAxjpIUae8g=;
        b=XP93U9kdsonR6hUWOkBVO4jS80UMJMuYOBh1Lp71qleF/8A4NUZcCDlU8BrUA6Np+t
         tY5JzSdqWTytMccryQExprmRwbBLQU5ESYYOk7W8RyzhoW8TiofIk0maGq432ShJrwlz
         hQRutqcosNxY1NMqK1dJem8E3bG4q0+aD01gBoVrQfR+Z8VYYOaD4DW86q8FtPgrUkae
         bteXtoUzqsQTS6udoQcjs8R69f681BaC1B7hOCWw3PRJaZ5blcl9f4zyZj2riNxCBmXj
         hDq81N0cZkICWX1hzmtTcBVJuQAliB6HP2UZqjUDFhPFUG7IqNMyXrXmug6E9Lb2lROx
         iAqA==
X-Gm-Message-State: AFq9FYI2LWMpc2ziO0FB4fRa6yJPfYCXa7SktFmnFdibVInlmWD9NrNF
	odf2+ylNvQJ6Yo/mZ1JcFNNl8sBTMCs6zu8PveUYHg0mfyjW+qc7SRCNd4aB2TWMlV0LJGepfaR
	HhIFmddQAZwWBS7azyeFb3JSkyNQdCylnY/PCNopy2kyy58dgrknU58v3Ug==
X-Gm-Gg: AYBFou1Z6yLKJ3PFbj2VW2Ye/cDbgn3rQaidSqfps0aESFX7OL4xagZ2QY8TV4M27e2
	iYFgCsm23298yn/9wc3Hg/PvvtfzAgRqB7gL5dhDbCSBSqnn1RekbYfSJ1y2+HypuLNncyg8yd3
	XHtly5cYrk7eCVTjKZMHb8sqli/EdKmJ9o3xI83dQj8VVL4vQdPb0yPMH9LeVmIOcfiK6DeBQ2D
	G50c1ezh9c09wgKG2Zma2DgViWtlJdG1N5xZCsYu7eTF6o2uEef8FCowc+D2dmqJ1NS9GruBgNB
	InN+esmufQHqaYHhtGV5uZGtgXtOB370yJIxljf4gDjWL9CFEhpE5vajK3e3ZEBwV0JfyA==
X-Received: by 2002:a05:600c:524a:b0:49b:9202:6f80 with SMTP id 5b1f17b1804b1-4a18e4a4f2amr223068555e9.6.1791872140270;
        Mon, 12 Oct 2026 23:15:40 -0700 (PDT)
X-Received: by 2002:a05:600c:524a:b0:49b:9202:6f80 with SMTP id 5b1f17b1804b1-4a18e4a4f2amr223068115e9.6.1791872139817;
        Mon, 12 Oct 2026 23:15:39 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:3fd7:5300:3d6b:52a4:a23f:9d0b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18bea0f1csm493452445e9.9.2026.10.12.23.15.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 23:15:39 -0700 (PDT)
Date: Tue, 13 Oct 2026 02:15:36 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
	andrew+netdev@lunn.ch, jasowangio@gmail.com,
	Willem de Bruijn <willemb@google.com>,
	Paulos Yibelo <habte.yibelo@gmail.com>
Subject: Re: [PATCH net] net: extend virtio_net_hdr csum_start checks to
 VLAN, IPv6 and IP options
Message-ID: <20261013021523-mutt-send-email-mst@kernel.org>
References: <20261007163819.3041710-1-willemdebruijn.kernel@gmail.com>
 <20261007175957-mutt-send-email-mst@kernel.org>
 <CAF=yD-+ZROFbKoQrgz5kGVXZyCQkvDb_gVv1dLCKTbT31sAQyg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAF=yD-+ZROFbKoQrgz5kGVXZyCQkvDb_gVv1dLCKTbT31sAQyg@mail.gmail.com>

On Wed, Oct 07, 2026 at 06:38:33PM -0400, Willem de Bruijn wrote:
> I can drop this if you want to send that instead.

still working on this.

