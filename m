Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80E593D8103
	for <netdev@vger.kernel.org>; Fri,  7 Aug 2026 08:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786093085; cv=pass; b=WSCcD9vd/5Iij6hIVw+dvPo34fREBUPH85cjh3HxoT9OCQ/mG3rlW17B8ZltpDN7VNRXWa5ddPPstzzb8GLIGF3C0/n3TIsWkPXQ/IyjG1KIHo3hOVuYkjrBz3FAzHwV3BU+h3yTRiMEpR7lMYEubZgv3UmSJIYS7RlV8dZ8KCI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786093085; c=relaxed/simple;
	bh=ZxbrVGxBp7yVKwlHa1qQNTWf1puHjwTku4y+NBPxXnk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z9J5puYBc2otJj0/LCzQxj+FWq/aCwZVUq2VcfyeUjCyaGHMK06zp/q2FnmvURI/eL1v+9hJpvzkcGoRjWb6R8txCRYTUyeIz8cA5MXftDiP/p3hvnYfkM+LBlURQHbHkXXK2RsGm1Yaza2TVx6/B/HKE0G+P9mZR2/Sd9Mu7FM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GtUs8bWV; arc=pass smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GtUs8bWV"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6a0a4a28cbdso4560865a12.3
        for <netdev@vger.kernel.org>; Fri, 07 Aug 2026 01:58:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786093082; cv=none;
        d=google.com; s=arc-20260327;
        b=T4uoLka5L9UAz1qfXrofyqzDs7KuFO1zPBXeOwpKUOWgL6KkGPIgpgVTAOZaLy2Z70
         rz+k3/HhqFfAwYeH/U4hZ79e7X8F343pnCjmgKWAv1hNMJymvN8XoASYX/iUPaLnjBdF
         mJiCyxIOBKx9PnfdtgAs36kmD9lKJUpGoq/j6JklALRr05TbULo6hN/nLGpvsEIkv67S
         zWH80keqM/YDLb+4BPWaolcsI/jp3Jze3hjRtNDu2ZZNC+K3WmDUzV/KKCYBA8GKc+lf
         AiLtnNg8aWHzNW7M/OwxtpmW/Ud9JhZ602urMBAyWO877cOREhyvXCPYFJ876jtY/V58
         nl6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ZxbrVGxBp7yVKwlHa1qQNTWf1puHjwTku4y+NBPxXnk=;
        fh=Tx56hlzP6B42zqlRQH+mwDSKxm9Do/azsBX1Nm1t0VI=;
        b=RvgsgYgZPhdg8JMpGKp8B741jYWK1MtD4W5sJSETXfsj6N3IeoLyCBs4K+4nAagOQ6
         PXGbMedj4l/uHsg+dGvr/oT08ND36hos1WlTNngcgOEjhCfCDcVjAsb0ungTJ4jVMvs6
         gKh+a2KjhIjTVDAxFHq/oRCGczspWPSDVxZyNLa17DO/BEiaWFUF0AWxKoAIaBb3/6FZ
         Xo/Ht735FSPsDS3GfNgsUc4L7QKHXxLPJ88vOCcoY998YGER+MBICpPszoVrbo0Z3HTW
         MiL/1W5wXd5fc4awUokgP1qfKvWdpkQrS2r5HN85kip+XoyC4+8lmqVnmmPaGx2lWqKO
         Qlbw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786093082; x=1786697882; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZxbrVGxBp7yVKwlHa1qQNTWf1puHjwTku4y+NBPxXnk=;
        b=GtUs8bWVlQMjERRydOvwcJZjaSSudiVAiqUGc+qf1q2+G5QtVEHhTXDXtBcxGQuEZg
         TZTyr/QiD5YZlEzy0rAHvWes7JUsTtLv/fXOW0FLJvu1HV3UsXHa4FwPfHIvZquARN23
         IC+1x92T16ho40Jp+m3ZlGswS2HW82vmI4thLMISKT31+o1w/Bh4FsLquvDiaXEaWfH4
         sJqWU6DEWy4ihsdLIcxk6toLKOq/n8eXT4H6sftwCfyl1Un4UVDgFlnOIDFED5LF7rQ/
         0mhcub9Svm+r/k2GlrFCTS3bkVeZM4d5JyVzINltqYR+X78t5ngrD0l1zUQuIDtz1nOu
         PMEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786093082; x=1786697882;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ZxbrVGxBp7yVKwlHa1qQNTWf1puHjwTku4y+NBPxXnk=;
        b=WkosNrUDJL2OkuJFCB2MR6tY8MPN8cqpMm0BIZcF7vGhlt4DtMMBHuxFdcwy0J+egs
         bNSdY7xRqmSafwVe8yi8fiX7ta4xnxxZNHwGJDKT2oLPS4PO1e7/l/Cjp/PFoQ9XkJHp
         ttQEhdJFxbpVlX7ecrBElC1W3LAYeb54yibm56upspvXTctdwBNbpOFQ327OT3FKLiOC
         KBVcPmQb+1fZ2iZa+PFQd1Z8f+sshLDMAIGeedTqXuvxf+67ynJhMsT1AsPzfSlJ3osR
         iCZ5Xc1IEDNJuf5VXdxKae45k101FANFsZk1TzHfK8l95DUFwCsF4nVpnpQTQ0CyTdIO
         4Mbg==
X-Forwarded-Encrypted: i=1; AHgh+Rq0xALkdS3WDaXzq+mF/RooURtiQBiJdym9cHnmD/D64IcUJt7MU53ssGf+4SsN5t6y/TPH3tM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJ8QSVy0W/VTHg3BqlsXlw3UgiqjZn+5yiVj7RtDYShUzvReOs
	z/Xjr2t0+25vVJKQDGiFprL2Oi6Ga4KcS9gsg6rgkgHLnUIJXbgihMGW7S5xF9eELdWuKVFxMpm
	1WFI06EyuJ2pBcVRsOpqmdO9xc8oLk1q0yUOl2OvJUw==
X-Gm-Gg: AR+sD12D3WlX4et8A9Agayd74Ib3TJPY1WS6MAw4jYSr8ixwY8HNrz3Kydq8OlfZvHI
	C2vg4117hAaomAiMRrg/1Zh2M1UhTIaJBhrZNuYZaCJ9ozxmmWTwiIH+X+w5Mz927zA6VCw9R0j
	w+YGvM/03/b2jZbcSmKqL1QK+UiMGdo5JI7ERQapuUzcsG7ri/7ZkanHKEh8YlL41nytLqAE3CF
	elNBW4pQ8fz74zA5Tr35PJmjm7CPtiss7xSHGmap7oYq1eDg+jSRoKN5j+xCRltc5X8loSflAKt
	o3nhFpvEdVr+nPeWDmoe3g2OWBidU8TUjSiB71GTLYQ=
X-Received: by 2002:a05:6938:a093:10b0:c16:66dc:3abe with SMTP id
 a640c23a62f3a-c2051ec5e07mr650524766b.28.1786093082291; Fri, 07 Aug 2026
 01:58:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260724110111.18783-1-running910@gmail.com> <amyC7_3bbwJpXIPd@chamomile>
In-Reply-To: <amyC7_3bbwJpXIPd@chamomile>
From: Zhixing Chen <running910@gmail.com>
Date: Fri, 7 Aug 2026 16:57:49 +0800
X-Gm-Features: AUfX_my8tPdK2QqmZAQFkJZ_YeSAMJRe7w2lCGZIQ9CKHeSLIi7oH4wDjrLrac4
Message-ID: <CAMyuFdU0m_VZU+cDAJXROZTqJk8HE75mu47ttVManC_osg62zA@mail.gmail.com>
Subject: Re: [PATCH nf v3] netfilter: ip6tables: set hotdrop for malformed
 extension header matches
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: Florian Westphal <fw@strlen.de>, Phil Sutter <phil@nwl.cc>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, netfilter-devel@vger.kernel.org, coreteam@netfilter.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> This patch should target nf-next, it does not fix any real crash.
>
> There are also issues in this patch to be addressed, see:
>
> https://sashiko.dev/#/patchset/20260724110111.18783-1-running910%40gmail.com

Hi Pablo,

Thanks for the review.

I have retargeted this to nf-next in v4, as suggested. I also carefully
reviewed the relevant code paths together with the sashiko report and
updated the patch accordingly.

I have just sent v4.

Thanks,
Zhixing
