Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1365E26056C
	for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 21:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785447582; cv=none; b=mqbCeAHCyELQW907c9qBq3OZ7+wwDiEc/gwSfgaK4PR+G0EZ/djYQyS8E96VNC0VnjLjSWtqMWIdI8Ii32xsOZjdpwNwoGJrcW1z6rKCEhd/0mj2ndTbaqFfJdwGGF7E2H2sD5N6cmQRwALbZ+ZkRh+Vzpxi5eFy/smtTbQR6KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785447582; c=relaxed/simple;
	bh=9tJFneElzryi7QJmNthwEc9KGHFEub4YMJqT7VjvA3s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vv1s8u2KsjbBMEupANlL1YVJ7b0k/SeiyVnZYAasnr93iGrx/TvoeWrPPzvc8B40fpGOdn5RdRRSatzTKiU7soxz80QeUbOFLrpMW5vRBxU+dSnAp+oAkL9w/mOCNyNl3YE/Ih39/gfx0aZN4uCtISocXREexu+TeVltRXRUo30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MJ/vL1Tx; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MJ/vL1Tx"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-84a2dcede83so498707b3a.3
        for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 14:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785447580; x=1786052380; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mlBdZN/Yu2XetCK2pd4kqserGOdzhIFqZOg4RXy2UAo=;
        b=MJ/vL1Txjc8o5qEj648LXNRRPCEFXsBDqVTHyJoWsmM8tHroGqmL5B/ByAJL+x7EKW
         Pq/QnOlAJUB1T9kPDMrbYeJwjt227n5Zm7cmKWmJ4TWhBtJz/eFerq0dmAU1WVevtN1z
         hmrK4UpN6vPJIc/WgUngSBeVWQw++a6Md8JI7creJzt3YSKLjlixCUAewrts+5/n3JKc
         Ht8sbUrj3KcvqwxO12JF8U/PdKAPevnPtRt5jCpDKBkeLXmFmI5GAOFjyP0oQOncaiWY
         ditPt31Lth2es2ej8oQWV+23S0q32vfzSOorHdlCpe7/Xd0pGVzyKiAJPjUDEpi6FYvS
         cAHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785447580; x=1786052380;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mlBdZN/Yu2XetCK2pd4kqserGOdzhIFqZOg4RXy2UAo=;
        b=Q28myOmEJlSG977FbKFoTAa9p+k/hWVT6mLgaz0mOBJysNJ9+XpTlh1XQYV9iLB5Zz
         t2JnT7o58S2VAV5syHtb7u1/vO4JmluOGqYIuqhWVdi/bpZ5FCDC8Ln7ROM+EU8f2O7X
         qZtYGPjyrZKxsTqJZzHFH/ayY/ohS7vOmZlItJc7fT/J+GqoEqveMX6t3DQuZONCmDGh
         CpO15Z7jw7UnDDgwYjiac+2g51QKtxrsB8gI018nPxBviX6LneTiXIGLeMymOXgONdWP
         NUFGdNT/pqJ+gxnurqngVUjnH1KitwTkj6tWKsufDCF9HBOIk9UJ3t5XW/CTkM30Lz5a
         gJcw==
X-Forwarded-Encrypted: i=1; AHgh+Ro3hwnIRS9ubz/cfEt30W+upL9vF2cey+DLiL3/55mMzXOpABGN4yrxNY7os2EnRXcxaWO/QUU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5nNz7uKaBjIr2ZhtkoEj7qzRZqnJBGwlNjtqIbhZCPiTDlaDr
	lxl20er1eOqwhU3+3AUnaxTs2mWKh1hYXmY4R7hdtn6KRXN1EcDOmL8i
X-Gm-Gg: AR+sD13YzmUfqy6DH2RLnM3yKuVxCdW+d2UdLMf14CTCh78IfFrYs0q8BcTKExfVrCJ
	I//BiGUo00fKFBsK3IGwQhTK1DZuRQyW3X+Yb4z/oP4hQ1OLyy0AwP3emPZA1KkLx/MhgbnGqte
	7182vgCsyqPcbpPtlaeX5NINldXFEce0dbull9wuzakHHG6ZrAXvTn8u5LnrZLkKNVMnaHXB1sd
	hNplDps4oAcLhl82FU6Jy9IbHZER5WpTtxuGTfJ+M9ySTu4mhxa4qB+LXlr/rwJP9LB170oX34s
	a48IsLI77LV5Pq4n0+fXPRIPdkCaNt239xXyctoUOHnhJgc5ZCIUTKO0Ddkhy6D3nszbnFD1shZ
	pQdFVCeygzaIbjAF5RBf5ZMXlPm+DIGLfK3gW+QHewD+aKIL/0g9+VlT5K7bXPy7m1i8g6Z4jzy
	Wu6J/HdXbtp6fQesneznJpD9EWKdSluVJFA2UAVpEpTS79WJyPHm8bO5KnODOLKtDrSImk881Uc
	DigBqHkkg==
X-Received: by 2002:a05:6a00:2a09:b0:845:44c7:5e28 with SMTP id d2e1a72fcca58-84ebc2685a6mr3911212b3a.31.1785447580388;
        Thu, 30 Jul 2026 14:39:40 -0700 (PDT)
Received: from devvm29614.prn0.facebook.com ([2a03:2880:ff:46::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e9fe1d07dsm3618306b3a.8.2026.07.30.14.39.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 14:39:39 -0700 (PDT)
Date: Thu, 30 Jul 2026 14:39:37 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Donald Hunter <donald.hunter@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Vivek Kasireddy <vivek.kasireddy@intel.com>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
	linux-kselftest@vger.kernel.org, sdf@fomichev.me,
	razor@blackwall.org, daniel@iogearbox.net, almasrymina@google.com,
	matttbe@kernel.org, skhawaja@google.com, dw@davidwei.uk,
	Joe Damato <joe@dama.to>, Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v6 3/3] selftests/net: devmem.py: add
 check_rx_large_niov
Message-ID: <amvEJVio9XtCn+YT@devvm29614.prn0.facebook.com>
References: <20260724-tcpdm-large-niovs-v6-0-7975f62cdfbb@meta.com>
 <20260724-tcpdm-large-niovs-v6-3-7975f62cdfbb@meta.com>
 <20260729191649.55ab7942@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260729191649.55ab7942@kernel.org>

On Wed, Jul 29, 2026 at 07:16:49PM -0700, Jakub Kicinski wrote:
> On Fri, 24 Jul 2026 14:21:17 -0700 Bobby Eshleman wrote:
> > From: Bobby Eshleman <bobbyeshleman@meta.com>
> > 
> > Add a new devmem test case for binding the dmabuf with rx-page-size=16K.
> > The test sweeps RX payload sizes straddling the niov boundary to cover
> > the sub-niov, exact-niov, and multi-niov RX paths.
> > 
> > Silence pylint invalid-name (`with open() as f`) and too-many-arguments
> > (ncdevmem_rx grew to 6 args) at file scope.
> > 
> > Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
> > Acked-by: Stanislav Fomichev <sdf@fomichev.me>
> 
> Hm, odd. In NIPA we're getting:
> 
> TAP version 13
> 1..1
> # timeout set to 0
> # selftests: drivers/net/hw: devmem.py
> # TAP version 13
> # 1..5
> # ok 1 devmem.check_rx # SKIP marked as disruptive
> # ok 2 devmem.check_tx # SKIP marked as disruptive
> # ok 3 devmem.check_tx_chunks # SKIP marked as disruptive
> # ok 4 devmem.check_rx_hds # SKIP Test requires devmem support
> # ok 5 devmem.check_rx_large_niov # SKIP Test requires devmem support
> # # Totals: pass:0 fail:0 xfail:0 xpass:0 skip:5 error:0
> ok 1 selftests: drivers/net/hw: devmem.py
> # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
> 
> https://netdev.bots.linux.dev/logs/hwksft/BCM57508/results/755681/config
> driver: bnxt
> fw: 237.1.148.0
> 
> Any idea?

Poking around, it looks like 231.1.167.0 and above should support
everything, so fw should be okay AFAICT.

Looks like the config is missing CONFIG_NET_DEVMEM and CONFIG_UDMABUF?

Sorry, took me a while... was certain it was a bug in my code.

Not the failure here, but wondering if this was on ARM led to seeing
that 16K hardcoded rx_page_size in run_rx_large_niov() may fail on ARM
with 64K pages because it will fail the IS_ALIGN(16K, 64K) check...

Best,
Bobby
