Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A8F3793A8
	for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 16:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785255696; cv=none; b=VjrIvr9HbQ5tfgo+PIS0a4EB4W2XSHUAa+uP4f6+oxYlfQOMga4JGVg76kixswT/tjCwbfK/LriXIY37V04RTa3mUYjSl5GGjAv0GS63mp7keRSSzJsoAJF5mJSAitIDAmLzMYdvwnk2Crlnzp5iiQryKcVEmJOrM3uq4nL6QgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785255696; c=relaxed/simple;
	bh=aFGt4eGpVUUJsFfYj9VdELzPH4A1+vp97yG8fzI6llw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rim0D5aW3jzO2L6paW39hOV20qBWDwvcfnet5RuMmPE7eiV6fA4iDBQAmrGNKmoC5zeAcYXWhWS8s1ZP+2rTkXgEVBuRlmHAV9jbsqQqOLYvW/lL5XJsqSZTXPdOXfqfhtHHkO7xw8SM34JfX387dVK9BCHwnYkY2Sqf8X8DnqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=YR+dzJ/U; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b="YR+dzJ/U"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-84867f07d63so7304b3a.2
        for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 09:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1785255694; x=1785860494; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=T9YfnxvbCr50Teby0V6rb2WP5ZtOhfF45gbSFID9AZs=;
        b=YR+dzJ/Uuy2Cadh8m82hPmVoSpCmfYJXFqXGhYZLtSvLNfAi7oP/IVzjI8ZfEH/qAn
         8mJnfeBoIoAfUqefg1XBQ+q1OPKtxlwNfYO+/ENhcUhIyH9uZ/ggLfDDlNkSTfifGu5r
         lGV1PtOv3lGy69DbSfj9ioeX9GDqvmyYlApQEmyTNWcG+ZafMjvTcvgTH+0WYFmyo2aM
         jRrFju2vIDGekBsD/q+OK6YiiSRJMrBx4MexCTHB1dGS2pNn5USNhKSnYlPrGP2U5kYf
         iWjpb2AJk1BdDm8BFej85m52upG67hnhgQ4iFoGeF+HdcH0tIfPd3MouegSVcvPHY2Fc
         VKIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785255694; x=1785860494;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=T9YfnxvbCr50Teby0V6rb2WP5ZtOhfF45gbSFID9AZs=;
        b=XFyn5maq0H9d3Zn30eB7oysmp1vbHJXMHmm8nc7TH4yfMwW4YIRbycIeDHp9ALkHZF
         ehvRZlBOLdj9PoChc9nRJs5RQDEcSNSQF6G+4pWS/01NSi3BvqMy1LFV/X7MJ0gOC3O/
         Z7VX5pO0M1CCflhDDKAh9LXjuVL0oex+G9TharEKS/aVGE6RTz4z6N3ReKjVJuJ1btrG
         EvSPl5Qe5UEuQoVFT6rQdaS7ZASRHPEpPdWzyOoZZeBvSxrX7tok9d67IG+golEFxKT0
         5NEPcmBb3l2iRyHxThWCHyP4dh7ZejtajMAraBHeZrqUwaXsdvy/luuIFMO/+n4GF6CC
         NTzg==
X-Forwarded-Encrypted: i=1; AHgh+RqnFsAB6hf0sCzuxhUBOdbct2vG1aE0lw9SLuZRH3CdA7NOLCrcP/LrFSrOTtPOaadLYXuyYJY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx65/5XGURpKLRjVFyh5mYccWjyhsqP3/0bz0WZBPX78OhUErBH
	pP+AU46nafpXtNrDZREWTS1q7P5l3WsFbnu/EaWPYi/DBgsdrfWhLfxJ3Xmtf7O0IEo=
X-Gm-Gg: AR+sD13TzMEGnXH3R2kJH7w+AGqStxFeME/Oe3Ubq0EHhJUyfx8ZpwVPQNq/z/oa0Zr
	/kwS2Lez0QDvqYjKvTUlo0S78C3q6kT6T+wz/X5n6hwF5nFeoLNxfPPI0PDwO9FlocyjJPo7hdM
	S5DcXcJ1/U6yWtsv9ljh9ZeMQg0KPzvPkHMyntfIJ4joj6dkwX5/NO9SD1S/VPDuRmXUvcF5/Ca
	G/OmZeyzGz/Tu6BiWaPSdbtrVWME6MJdYgIhzRnqdFvS0NW7AG7A0QQsdpqg4AIB3iNUl+YtfVc
	yQmMztGDIdZ3FhN7P1XohxXBRz4/1xBxKBxEvDcqKtXcqrmZSfK7p4F4pRn1IzL6KQ1FaOTwC0w
	nU3NAi/aGewuHRMAqMJrfwMnyZ5bwihKpBGCkL4cslW0Y/ejGR1W7m6215Q==
X-Received: by 2002:aa7:888f:0:b0:848:44d2:72a2 with SMTP id d2e1a72fcca58-84e932f43c8mr3258665b3a.27.1785255693663;
        Tue, 28 Jul 2026 09:21:33 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:5::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84ea03767bbsm169007b3a.47.2026.07.28.09.21.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 09:21:33 -0700 (PDT)
Date: Tue, 28 Jul 2026 09:21:31 -0700
From: Joe Damato <joe@dama.to>
To: Shaikh Kamaluddin <shaikhkamal2012@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2] netlink: specs: nl80211: fix TOOD -> TODO
Message-ID: <amjXCx9R/GCiP4nE@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Shaikh Kamaluddin <shaikhkamal2012@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260728154142.12133-1-shaikhkamal2012@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260728154142.12133-1-shaikhkamal2012@gmail.com>

On Tue, Jul 28, 2026 at 09:11:42PM +0530, Shaikh Kamaluddin wrote:
> Fix spelling error reported by codespell in description strings:
> TOOD -> TODO. Attribute names are untouched. No functional change.
> 
> Signed-off-by: Shaikh Kamaluddin <shaikhkamal2012@gmail.com>
> ---
>  Documentation/netlink/specs/nl80211.yaml | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Joe Damato <joe@dama.to>
