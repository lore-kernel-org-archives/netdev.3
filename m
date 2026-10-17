Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D5522AF00
	for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 05:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792215405; cv=none; b=Yk7H8ee+9+pkUeAPg9WEd1UsW02pZcKouqDz1uc4lNTdsVyS+aGVr2pcKzGlOuK5mn9ardce86fWZy9OR3MHtTgRYtlSiqw+MqubDaC5IYJpZ0zTXIh/8/Xj3NtKNDyUsTE67TF/ckcUkUwFb9TCbXc92tICBq9mHtqOxjquhns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792215405; c=relaxed/simple;
	bh=CT0wh3KwPJovAUEvvTmUQApHxZpLs6H7xszDkTqLK6g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tB6qA193FPBmK5vPllx2+90ya08cEjK2BbHDtvGimzZSR9kAFVJI9Eb1lcPSGLKpYRWpVYsODAeOYbxJmE41rM5u3mLSukEbvChJ3XybwEVyZpYbfuQhlL4p0NBtPOohyEzM/iYsoTlCmpkQ2yUBWfmdhMrTUcAhvhDAvceq7Jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VUr87Xd6; arc=none smtp.client-ip=209.85.216.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VUr87Xd6"
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3ab7f1efe5dso1190659a91.1
        for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 22:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792215404; x=1792820204; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=slLcWG1N2gT6IfvpJKBO52lrlc4iEipRoMwUKxC7sOk=;
        b=VUr87Xd6OaSnmOiqaP9LaN1ITT8omdRwPBrbenL9T4Tvfa/EGGIuWWuFdsX9AtDsc4
         pNWsvN1QZ/HzoAtsyH0A4NaW8FC2gJkW8n68CFBeh6NNuBdkWXSsxjbYdUQmGg7hqMW9
         3P0B0VLag80ks4M9f9ZGkeUwFgaGiXK4H6gfNai7zqD1V0BqTG/HlQV1/2egmtOjNCud
         S98aWb5XCCSmiIh28ZtfB0tRcuv7GgpiAVlYi8NJNZCI1ITqqtwoYfOlFHhK4O4wL/tN
         +Pj7o1yM4zItbp6+GdPN1ycbJl36VjbgZMZkYUAw9o3uoPgl6sWizNxJRwrRY0RduO5F
         eFGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792215404; x=1792820204;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=slLcWG1N2gT6IfvpJKBO52lrlc4iEipRoMwUKxC7sOk=;
        b=2kqboXa3KXBGkbdx1HR9nmJjvEiAXHUq+lSZj3p9Tr+rmrtH9AVpREW7SRX6us7mmD
         /wcehghANimP6BzpAMqHxw5TmDoxTR1e1q5m4XXqIPmGIYLQl3Tq9X+rqPg6Zjw+9ym8
         Nz/sEDN54FhfteVMbdJGfyHTJnica5Dya5t22PXFQQvo/BQvB30izIi1i6l6ThFu3V2y
         x+uA7kFCO4XgKUdSVXhmzNlAr44cW/47A7LiQp9pC/qcP+SjE7GLf+CzxeK/V6QUg2/x
         /97zwed9i3jLcJzijiybmrmPFYUIDERy5qPRRyFV9JfmjHXo6JBdek+5GI1r9nySS5Oq
         gb0Q==
X-Forwarded-Encrypted: i=1; AKwUvBxypc1Ubk9U1ABvy0BWAuOjUx4Q5BRIZcQQA4s1UwuboVCn7yXXKX6L86pXDO6r1/OhFT8Px6c=@vger.kernel.org
X-Gm-Message-State: AFq9FYJdZV0nBOLv8PLPyLvKflsb8IJugPDrZCjjr1aNIeERaErE+O9K
	sHCBV4WmicFBIsRT7aQIlNlgQ1i/mfaAGFHmEuJyhh6TyeoVCdvOPRxoHR0484TyLL4xYGf9CSj
	WpU3ZFQ==
X-Received: from pgde16.prod.google.com ([2002:a05:6a02:310:b0:cc7:d698:697a])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5745:b0:3ac:c03a:38b0
 with SMTP id 98e67ed59e1d1-3acee27798dmr1827553a91.8.1792215403626; Fri, 16
 Oct 2026 22:36:43 -0700 (PDT)
Date: Sat, 17 Oct 2026 05:36:43 +0000
In-Reply-To: <20261015081723.404990-1-parri.andrea@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261015081723.404990-1-parri.andrea@gmail.com>
Message-ID: <atMJYPanib4g-C4q@google.com>
Subject: Re: [PATCH net-next v2] rtnetlink: comment the RCU waits in
 unregister paths
From: kuniyu@google.com
To: Andrea Parri <parri.andrea@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, 15 Oct 2026 10:17:16 +0200, Andrea Parri wrote:
> rtnl_unregister_all() and rtnl_af_unregister() wait for RCU readers
> before tearing down what those readers use, but do not say which
> readers they are waiting for.
> 
> A missing wait is then easy to overlook: rtnl_link_unregister() lacked
> its synchronize_rcu() until commit 3b70edea393d ("rtnetlink: wait for
> RCU readers in rtnl_link_unregister()"). Add a comment to both waits,
> naming the readers each one waits for.
> 
> Suggested-by: Eric Dumazet <edumazet@kernel.org>
> Link: https://lore.kernel.org/CAL4WiioFMQN4troVjQjCmE6Z9kwwb95SnoEupjD=PPSK6Q5f6w@mail.gmail.com
> Assisted-by: LLM
> Signed-off-by: Andrea Parri <parri.andrea@gmail.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
