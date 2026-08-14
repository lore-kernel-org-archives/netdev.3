Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3263D343886
	for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 20:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786739104; cv=pass; b=W2sX5c4PtQjrq3ygjSt+LZiQByXhlLLIibgm3enF5y72X/GujCr3kNSspAD3HyDdGfYeNyyXusx5qOqm1jYSZi+rQL7eZ/szOeKGBwrc/P4jIr+UZBWqHgwzeQkwhuoAdsu9CWL2hxCnW/7Tj1ml1v3Gc1mRLBuqHaZpgzd7Nm0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786739104; c=relaxed/simple;
	bh=7pAEGI8PIZ1O3IVtqZY+SQl/XNs88tfM3zHdS2mPS80=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CPmarATIyF2UUlE8SPk1EbFMuTIDrh46FtOuQZu5sl3e7nuUPqoQRPck2d0HRMzQKmc+xrwYfJs8Z7aKpnnHnocYSkdtV6pKptZxZuQK0QfI2nYOUFu4JpLEK6A84xhjVwQVAznEO+tFqNAcsUTW8CjP+/sKyLWtRhp9RKq/Kro=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wRhEtV4d; arc=pass smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wRhEtV4d"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2cede6375caso158165ad.0
        for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 13:25:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786739102; cv=none;
        d=google.com; s=arc-20260327;
        b=sMVMyZbmsqiHAaN+yjydW8ICaeEYsvRCJK8pqG7BazOIs+SUMZGvGWCWKY2giyt4Tf
         LL98LIhIl3mvKyEsjZhr/uwiOLQvIG3QDWWjbFBmyNVHiOkcsxvtuLiNal2crRMIOauD
         6xe7x9oOL1kPu2FOjw06EOC9bDY/r9RV7lXJ1ZuYVEriRDJmvtMxZXJ8pCbXecoNKg9i
         jRIQdEABwp831tnlqmQFY9lB/ghO9mZfGmUke9jvs+jswoo9lbSaqpe9bK9PZxl/sQ58
         Zyf/VCKlJgs02CRgoGKtUKjv1Nptrrlb9c13Tsrcrd0IiF0c9Bby/ugz0773C9k3X9/M
         Vv2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7pAEGI8PIZ1O3IVtqZY+SQl/XNs88tfM3zHdS2mPS80=;
        fh=yTYzHmnr1B5+GGzLzQABnUXmsXy/GUneDJ7UnyoZNkI=;
        b=RufVgG7HrtttNw3vfNjHOKE3rQpmkxTS47Bd6PtzGsojYiwGsLKeSqD/RRDSuT6aYv
         TEu5bjF5/Gy1swbeHNeTJ+RKzfC67Dc7fJwR6rpQDMsbQlFIXbGgBsUInlO4X5GlAKmq
         dIcFyY9OSujF9s1xgfCfOfGdgdju12Y5Q3S+i+UyHoECDoBLF0RdG0erWho5v5SpYwgm
         U7ShTwXK9V5Q0wCxkBZfv9X1+ytpk1+v8NzPF9PoI0h9ewaVMOK6XXyWorMay7pGzpGC
         QYiwJHE/HLbUu7VByr76nRRXn1wkzNyIFwRprN68+ANidtKKAJZ1ACvCCLFPU2bhw8dk
         FD/A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786739102; x=1787343902; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7pAEGI8PIZ1O3IVtqZY+SQl/XNs88tfM3zHdS2mPS80=;
        b=wRhEtV4dzhFO8R56ULgwlCEQ+vFhnUsDsq9VXL0Qp71ElOCL8FrSu6YPQ7ml+woGXC
         x0ABjSqR58/8CwfhZnO4cyqREsMOersG95Q3eNToszA9B5Ig7FSVp1eXBIRmyuVf92JP
         nSN6g1dTLWpq8aRW+CBI7LPcuzGt+INnsvmQ/ir8w1Yr2TKIDFz7tVwOCe37GWk1emDN
         5OV3xIdgkTVi90ov5Pv/9ZbVPUf2X2dYdifpkhteTFFSx8XN+y+5DxUOuuXHi8TlXuWL
         SMOIOpKegGicW7aQNIGshwEzqeyKXUILm2UkXgypX5ETBbnEcAqk8niy+djnDpBSi6CB
         9MsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786739102; x=1787343902;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7pAEGI8PIZ1O3IVtqZY+SQl/XNs88tfM3zHdS2mPS80=;
        b=HCf2yqs5XSViGeLAAOgh/RXs7d0HE420dTjbavEHdqmGmFjNrSFUzqx9DVf6aVCk7t
         okAk2BHrLyR98IWTDvfAxPR1gAem5oWtr3Ik4ntU1nXgDmOc0p5hfR0t9SByNF+dSTnV
         62jlSUuF197qHGYtnDw97IGzd0JMyXOlo57h4M1sYzKJk0WYFNU98IDG9G70BvmJOg85
         fbgzRJDKYpr92n3P7tu5cYkjobS+0I+QPTyrnwTIVai65XS5FPgPbmmh4dfYNFHHTKRg
         KyIgXZsQIeJoQV/BJNVLDlOjNX6MhckhQJI+NH0e0lkbSXRxIsM+PcugriCg5Jml6UN/
         zspQ==
X-Gm-Message-State: AOJu0Yw/30ZKdGYhSQtL+7IVHgy20B5bf856YtShjjZnXyNorbYqPs3v
	KuauQS92lboCEuLhOAmdPOPYGfGIF3jQEwZNl8holOk9kUjTfXUttgzgDW4SMZ24ooxqjiFVHfa
	VWNoP2nYPBUz3fB79AoV3ismEM382GK5BbOlA4eQd
X-Gm-Gg: AR+sD11AJCEhAECDht0nrNfp3O7zao2uHqt6jFZ/4WccQk8bNY3xsN8bdBS+81ExzeY
	/H+UdgFoI/UQjsI/0HWM266T7PyoQJjrPAdDH1fZZ0hjaVF3Xik6YIAk6Bo/9kSthXuh0O0c7hw
	SsbZ8oio4qBUJI0+do6UkR7h1YNeCAh6a0XuVkuaRvAx/lS+/+UFQB+BZ9YUQJ0mtOXXI9ZQmwp
	k86tc39BYa57RMDJBTxy907ahDw66+cuC/g15/fdjG1ONCLu3ah6KBUyxZZMjhdZXbizCenBIQQ
	WTc77KQAiscyOXdPoIOaqKU4me/RzGsempeKJjAmcNVCg+5fyyrmwXGVL6w1EIg0IjlSZVDKuhZ
	WESUuErclFw==
X-Received: by 2002:a17:903:ace:b0:2c0:defb:557e with SMTP id
 d9443c01a7336-2d3b4786b29mr10751435ad.1.1786739101838; Fri, 14 Aug 2026
 13:25:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260803181852.491437-1-almasrymina@google.com>
 <20260806121631.13175f7e@kernel.org> <CAHS8izP=mgsdxv3AtjJo9JY5OHC17zeX-VbPPH_gFF=Ndb_qjw@mail.gmail.com>
 <20260806133435.38c34e31@kernel.org> <CAHS8izOU2pxfQH0Wo1DrqajOb54wv3Y1rMryGpwjNnoUsEufew@mail.gmail.com>
 <20260807145444.6acf9c08@kernel.org>
In-Reply-To: <20260807145444.6acf9c08@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Fri, 14 Aug 2026 13:24:48 -0700
X-Gm-Features: AcwNN1VWfc5e7OWOu3ewX7hzzrDJda9wrX13lGkA6AbZQff5o-vSR9tgOESKuAw
Message-ID: <CAHS8izPQn6a_eUgeL5otUESTRud1COHXg2SuR5g9qce1xJogvA@mail.gmail.com>
Subject: Re: [PATCH net-next v2 1/2] selftests: drv-net: devmem: fix 5-tuple
 flow steering
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Bobby Eshleman <bobbyeshleman@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 7, 2026 at 2:54=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Thu, 6 Aug 2026 13:59:53 -0700 Mina Almasry wrote:
> > Do you mean forking all the test cases so that we have
> > check_rx_3_tuple and check_rx_5_tuple, etc? Won't that be annoying in
> > the future if every test case needs to be duplicated twice? And
> > potentially again if there is another deviation in driver config
> > support specifics?
>
> No no, I just meant a trivial test that installs the rule and maybe
> sends a packet to check via getsockopt(NAPI_ID) that it arrived on
> the right queue.
>
> You can probably extend ntuple.py instead. I was thinking yesterday
> that it's nice to have all zcrx stuff in one place. But in reality
> we already have a bunch of scripts testing zcrx so ntuple.py is
> probably better.

Ack, will do. I assume you mean do that in a separate series. I'll
submit another series that extends ntuple.py with 2 tests, one for
3-tuple and one for 5-tuple flow steering.

For this series, I realized, yes, patch 2 is not needed indeed if I do
this on my test setup:

sudo sysctl -w net.ipv6.conf.eth1.accept_dad=3D0
sudo sysctl -w net.ipv4.ip_nonlocal_bind=3D1

so I'm going to drop patch 2. But I still need a bit from this patch.
Without setting the flow_steer=3D arg correctly on check_rx_hds that
test case specifically fails on 5-tuple drivers. Let me know if I
understood your feedback correctly.


--=20
Thanks,
Mina
