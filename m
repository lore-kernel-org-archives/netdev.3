Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7180A302CA4
	for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 07:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758094820; cv=none; b=C6+PJOiyzAukdXaHnTTijrCuklNyKVNeDoSPtmGyphx9Wj2jJYjllxqbs2Tt5dRD1jK84MzPfzq1/xsdGG9oPFqMxeq6G1F0X1hsWAnyTkeJXHgllqLYQnNH42knKKGZLDiGpMkEQASzhBzFfnSsIrI1mwxsA52ilmddGc1gnGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758094820; c=relaxed/simple;
	bh=iVDNLvHY8ShaFwgEpBiblYqA9FdT2BYsWKFXKU7hKb0=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=JP9nqoqdtavfQN9nonbaJZ3ZBfVRMoJ5XKhNTFQyKX9Elb9vBd8Jqlyn36J//of/hPiwchigAWxyEPYBeSZ6H53zST/8z/IoUAbOBwZfddU3CtY6NCgw+HHVJ0K7VFDbvvPw3P1kN+x6xHmaqO1vqXEuJXrcDAX7k5GzLQi+46I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.254.200.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid:Yeas8t1758094726t577t07824
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com [122.235.139.142])
X-QQ-SSF:0000000000000000000000000000000
From: =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 4785895773401471484
To: "'Jakub Kicinski'" <kuba@kernel.org>
Cc: <netdev@vger.kernel.org>,
	"'Andrew Lunn'" <andrew+netdev@lunn.ch>,
	"'David S. Miller'" <davem@davemloft.net>,
	"'Eric Dumazet'" <edumazet@google.com>,
	"'Paolo Abeni'" <pabeni@redhat.com>,
	"'Simon Horman'" <horms@kernel.org>,
	"'Alexander Lobakin'" <aleksander.lobakin@intel.com>,
	"'Mengyuan Lou'" <mengyuanlou@net-swift.com>
References: <20250912062357.30748-1-jiawenwu@trustnetic.com>	<20250912062357.30748-2-jiawenwu@trustnetic.com>	<20250915180133.2af67344@kernel.org>	<038c01dc2775$9f4c58f0$dde50ad0$@trustnetic.com> <20250916192544.36c20fc1@kernel.org>
In-Reply-To: <20250916192544.36c20fc1@kernel.org>
Subject: RE: [PATCH net-next v4 1/2] net: libwx: support multiple RSS for every pool
Date: Wed, 17 Sep 2025 15:38:45 +0800
Message-ID: <039301dc27a6$194e79a0$4beb6ce0$@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQFA/7Etsb+JxZdvJ6Pe7eBYG6K7DgGXMDePAjSuA00CQvneMAEVDKDdtZPWzTA=
Content-Language: zh-cn
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: MIEbEOayU4Louc4E46eBUvqQ0OHRFd+hAEB+9YKCrNNlCEfwhifsXs1U
	El6GmSmkLp5DvpOr0yUfS/WxZBkuL59sVsA4tiklEh9rfJ55mDxjQDs3p7skWibClSwT1q5
	NQEjTDoMC/YyFJRUIWe1ypzoX4ghBF4uNChgQJlJVPXQ7wpzOrM8nw8GNqlBofbRygoPn33
	QMExd0elMQtIzrfNwa7WxBJjjH3yNlfl7YByqQHRmgTGXOa97nO50jSN5fUbb+QmsWGDMwg
	7O6PFBLbj+S5UlS9Uoba8RyFPkFRrQqOj5oR0tzISutWmoCh0DO4dl3raXH7E9K0POWXG+3
	C0HiWP2hXoyYxB4Iijr3ltmPxnyZvHP7k/OkbUOM9wZLqzo1b7xSrWqXqSICLHlk3DNjXOJ
	39D8zJ68+xEXSg13vnvKY8yjUFRU+XHmx/n+14Z6uE/Je9inNg7tMT/ZN0xUzhYC4l3mkE4
	NtYXgIiS049u5CuMFvTKFWtx75Uw2W7eN11h0AWdv0QfaDGKONNjeLuA7RENkp7MTw97yAO
	ud4Mp6yJ/2wklMWsVY09Bh+d3it2/6DtIDmvZUA4gltCxywU+89JxjJFF8jn48EsqKRxsJt
	44w4K9GXoBIu8KsbPqglohIUdx4/EjykTJsRE5MsxF2Uf3X1zxdUErXpnB/tlwSE27CAypo
	Y5r1xQUaHpKGzoLMznDxK+pSoOLk8HuKx+INvqnfcGKy3zWJZjIQ9luzXzplsz5uq1Grsva
	WZ4m2fTa2s37k6UFoDaIFMCFeBRG/NHd40tZ3wpcwSeu7wo6+qyDwaQvqH2fo+MpimnN0kk
	acoucVp3jzqG43A4Jjuvowte6lobw74wuzOLmXWvLTeYG12F6uC52eCXQ7dNzJQHOjC1DC7
	Mn/H8j5iJ/x/UDoKEB5p5YWcYm14Emf98bTo7mc0/gkgh+HW65w+wj172RGgToXm6vhJHvQ
	53cKorz8IvoTOCIU2Cyn+Lv23lxtIEYfqz9UQBMsaSawwhdGacF6WJOpskf8UqTCyY+IA/p
	g7O8u33JCGtD7GcA9S8sfdGe2um2c=
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
X-QQ-RECHKSPAM: 0

On Wed, Sep 17, 2025 10:26 AM, Jakub Kicinski wrote:
> On Wed, 17 Sep 2025 09:51:44 +0800 Jiawen Wu wrote:
> > On Tue, Sep 16, 2025 9:02 AM, Jakub Kicinski wrote:
> > > On Fri, 12 Sep 2025 14:23:56 +0800 Jiawen Wu wrote:
> > > > Subject: [PATCH net-next v4 1/2] net: libwx: support multiple RSS for every pool
> > >
> > > "support multiple RSS" needs an object. Multiple RSS keys? Multiple
> > > contexts? Multiple tables?
> >
> > All of these are multiple. Each pool has a different RSS scheme.
> 
> Then configuration?
> As in "support separate RSS configuration for every pool" ?
> 
> > > > -static void wx_store_reta(struct wx *wx)
> > > > +u32 wx_rss_indir_tbl_entries(struct wx *wx)
> > > >  {
> > > > +	if (test_bit(WX_FLAG_SRIOV_ENABLED, wx->flags))
> > > > +		return 64;
> > > > +	else
> > > > +		return 128;
> > > > +}
> > >
> > > Is WX_FLAG_SRIOV_ENABLED set only when VFs are created?
> >
> > Yes.
> >
> > > What if the user set a table with 128 entries?
> > > The RSS table can't shrink once intentionally set to a specific size.
> >
> > Deleting VFs will reset these configurations.
> 
> You shouldn't reset user-set configuration of the PF when SR-IOV
> is disabled.

But the maximum queue number of PF is different when SRIOV is
enabled or disabled?

And for the global RSS table (non SR-IOV mode) or multiple RSS table
(SR-IOV mode), the table size is different on hardware design.

How could I keep the RSS redirection table during the mode switching?


