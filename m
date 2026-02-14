Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0AF1199FD3
	for <netdev@vger.kernel.org>; Sat, 14 Feb 2026 13:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771076249; cv=pass; b=YkEpv0y3NCWvuwgSOTg6BFq2RZyBcpi+t6CWpVSO2kN2puAs4kdk8DXcA+F4AU1/FVToeKWEX+DFc/IgWdowtv0Ieaj1eRwO4IYJB2T1O9MfwjKvblK0Yfo7txqn3lJ3Md9CNboJvxcQjNkZA2Avxl4HRWsvvPG4O8m7ChRr3Zs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771076249; c=relaxed/simple;
	bh=o4pQuwFTxZRxf3DCxm7ROlROJ5K+4eapGIa8VfHwwA8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LozhjTgkXeWHZLuPOPV5A0iPncXy9q1In8+tjp0wrfqZV07WipKcWj1QWDwRYVX4L7Ull1iQk9gITHTeCsbwTSHySzHoXexnk4i41te5rU6GM+XKfiWBz8YmhIUl2La7yG3geA52xHYFnFjidVKYLgUCXjPrnE/EJZjTrCp5PAo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aVYOSFVT; arc=pass smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aVYOSFVT"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-8cb3dfb3461so200195585a.3
        for <netdev@vger.kernel.org>; Sat, 14 Feb 2026 05:37:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771076247; cv=none;
        d=google.com; s=arc-20240605;
        b=Ai6ck8pVUM/d209s4SVJk627djhO4vKU3CDEmkn++csCaZAzyJ9Zuy7+EdXXGEn+Vv
         6ixst5eJibKHkcK92LPYmeUnsUe8UHgssurLSGz80vkWeVrxF8gy4QMixz3lbeh62NCV
         xwHQH43mAH/bHeprC/6arkdUnw4on8KtHzyYRR+iiNv5WQt/29dDPKt6ndddE5YERQ9V
         CgeHCnT4/Z+8vKzFKWFh+Sxt6h8EVwG8SlCcsi67kuR46JYfYuoHlkaNYGYGqknDIl4k
         DE/dqIKacKGyxFnUGzb12WVXtfVg8FTm6xEk5kq/yMAZOTm0wQm5zX1Rldf8RACKtooD
         N7eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PPZDRfMqJGb4FbX7P79z5OU/BNkhxAPLyDmRAxNPsEE=;
        fh=jHqwAXOUUcoH3PMSblLZZMmI/uOnqHlXolCqCjqi5d0=;
        b=Y7lbf3BnDHEdehMetcLGK7XsBOgtJvICdDy76fIG1EoSGBnt/lXTPCz9rhwUuCaRq/
         UZ5kWWsj/f20ezef17+RAN67oxPHCCM3b1wVA+vTAeXHIARtMLNE6dDU82n1t4LDnxZe
         zXkZRbnz9lg2eD9SBAaN+5g0aP37pm7Bggs7VzpjMqAWqDnw7Kc/zp3EKMAxJRQd9mfC
         XsfxExMz2yYP3RF0JFEd80gz/a+0Ol06Wjvfim8OfLoKCG4g0ZKnZVBLTPGNShgxC4F8
         Wktgl/Ql04qgfvmsjpiVcoPsybGQXsdpyV1EgwcJmRiiZglQjlWQAOfMK9ghCu0R6VTY
         mkYQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771076247; x=1771681047; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PPZDRfMqJGb4FbX7P79z5OU/BNkhxAPLyDmRAxNPsEE=;
        b=aVYOSFVTLxH4xQlodsu/1pSmSOK6Y+/k6ClDLNPikZ0lU+BkYYz3Agm6g+lk1IMt7K
         uGeehMf+8MHJOEj3r8EExCp6Bg/+eblta3du7irTwZZ1IsBwayBV9aSpJ9O05J5UXfx9
         GgTBj3SvJwfBnzDn7SI29yEMukTYv/XhrXDNSbyhWbNzT6cCBXHAqr6JJa19H/ZmqPJC
         ObbB4NlTUdV+/lh1oFbfvtktgVs91iBhXbrI06rf3Udjhtgtr34VZm25VHeXIcQie6Bd
         XyApQg6kw+RHuS9q1YasKq+RcEtSNb6t0kgXm5SOZjabC2pBMgXOMWlyMhxWFJwNlgZ5
         72eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771076247; x=1771681047;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PPZDRfMqJGb4FbX7P79z5OU/BNkhxAPLyDmRAxNPsEE=;
        b=ch/DkDDBbmtjnolKXN2Z25Nl4+FiQFToSDJd/YsJjOGpFWrBvMFBMBY5FV9ClfP9Hq
         fajz3JaBaZzsKi/zThMCfw/nJhD21zJUoFPxRrPr5+opAt7K4WRitMIo+1EBRdBh4PeH
         lOC9rzBTEu1eQ91Gs5wBTxjO4UYDFOt2yOJ+Oq/inIB5fZy41NpqgueUYyCsXdOFnUHY
         3sE8EeUz6xqhO5lfE0Jmc3QSJQAY953dOx5P/6iy0+sdIEnA4xIvJG2JnnJFlAO0mw9A
         TaP2rEVaKrf3nYfnEDGrXDUk2eHL5CTTjWYJoV0tRuY3lGNlgN0baMrIz9foHlwCxifk
         jQbw==
X-Forwarded-Encrypted: i=1; AJvYcCXbBArnoySsYviSj3S0XUy897ivAI8CRs3VY23JOIsIdU7TAg/8kw3Kpqa9kQrkfcf6qTXlZ8E=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywr6NvyW83iWuDjHq+W/1A/fCmDQ6Hu18F3MGuCmGJ3DZ+1d8Xn
	dbu9GdkxjS6Pl97rj6bthDHpywaTzGWTzkjTc9mybVIUnFd1h42c7mVJjRoeZSYukbzqnHjRQvb
	U4nSy8vHCOfW8e5rqPp1k4r8X2mzGvwZyXe+7C+Slg2nLJkrrEP4TwwUf1w4=
X-Gm-Gg: AZuq6aIUtkQMIiOU5IsTpRxrk7vEv+5rmCCUP1UjM3Pkxx47wJZQk/YuhfVYRT3EWy0
	FeN0WXCFrkRViknuFDNxXyk0JYS3rRTObbBBs/51APggPuQYaYmxuj7DHDGiRBh3u/JUseZCqje
	bDAMw16FCS3raE3odRBZoLjQ3xHy1K/gv0DHCiG5XCb6iAV54VjwEDoZkc5wfkhWcOQNei16bUB
	n/x2rtfi9iVrt1kWGFnksHk42zKpb9EaoElllGxcTgyYdkOhPWgW2RFmLaprY3WqEjDD8E9I9dG
	1Tj6vRo=
X-Received: by 2002:a05:622a:248:b0:503:2ca4:e3f with SMTP id
 d75a77b69052e-506a6b8ae0fmr74364661cf.82.1771076246230; Sat, 14 Feb 2026
 05:37:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260211202003.4550-1-fmancera@suse.de> <aY8uYmy1adhPqqbm@horms.kernel.org>
 <CANn89iL4zCq6gXNj7Yc_gXOrvtUhN+Zcdw5pbrUqZDgYez0ujw@mail.gmail.com>
 <8c9727bc-a1d5-4ea3-8318-f3fa7e558c85@suse.de> <89d03f27-2e08-4619-b556-772da4c38462@suse.de>
In-Reply-To: <89d03f27-2e08-4619-b556-772da4c38462@suse.de>
From: Eric Dumazet <edumazet@google.com>
Date: Sat, 14 Feb 2026 14:37:15 +0100
X-Gm-Features: AZwV_QjbytN0Y1dTP1JlhUVGx26cZje1ID_O0YkRSOR-r2cbCN-xPcuH6MvWXAA
Message-ID: <CANn89i+fNkeMJbNBJjqv15Rih1tUdC8ZwGqxjMZaxovcSt=hgQ@mail.gmail.com>
Subject: Re: [PATCH net] ipv6: addrconf: reduce default temp_valid_lft to 2 days
To: Fernando Fernandez Mancera <fmancera@suse.de>
Cc: Simon Horman <horms@kernel.org>, Fernando Gont <fgont@si6networks.com>, netdev@vger.kernel.org, 
	pabeni@redhat.com, kuba@kernel.org, davem@davemloft.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 14, 2026 at 2:28=E2=80=AFPM Fernando Fernandez Mancera
<fmancera@suse.de> wrote:

> I noticed the patch is marked as "Changes Requested", is there some
> action pending from me?

Quite confusing. The blamed commit mentioned RFC 4941

commit 969c54646af0d7d94a5f0f37adbbfe024e85466e
Author: Fernando Gont <fgont@si6networks.com>
Date:   Fri May 1 00:51:47 2020 -0300

    ipv6: Implement draft-ietf-6man-rfc4941bis

So please add a comment like this one ?

/* TEMP_VALID_LIFETIME default value as specified in RFC 8981 3.8 */

Thank you.
