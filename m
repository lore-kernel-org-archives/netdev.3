Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79621346795;
	Mon, 26 Jan 2026 17:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769450032; cv=none; b=Poi7XAIVZPvJjDR4tSjT+RaToCI4E+qqFO5TzR9zO/GRCtr9yxaWGtzDdpTfSz4qSUZyCU/YETH7Lh66ZAJgpKtt6ehDJvR74JMHw3DVfRTN0+ftE2s8OIfTd21JH7dGADI40Auc7pUMeAtEPGxiCZHlkA3s41b4HRr1u9NrHis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769450032; c=relaxed/simple;
	bh=hk87YrZr8wKIta1t8MmtJqZ4IvN5oO5ON/Gm0ZY7644=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Onizz27piC/de6wzGH876XCKwHvNyHiPbBupReYnFHJ/xDl8T4nEJmFBMtsbjQ/OEumKrrafZiYX3Hof1MWYaK6uvJYuzrU3nR9WWkbwLMexWsDB9LsdWXhP8ollC2/sz0seuLG8n+aY4pzblvZwgM5dnY30YL6bgHYc8pcctV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=wgUNFF6R; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="wgUNFF6R"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=A2imvv/Nv6V0KNHRD/nF05oDP6rOwODYhOBi0AG27QA=; b=wg
	UNFF6RNwFqhE4MmO35Y6RNXGbLuJdgKXeypTCLd0wdmwKylvqdUSMzRkfHRGyJ3n1Q7U/3RzWhYCZ
	Kw8srmoYia2s9vfQ93O+3cRzzSnzFP4wQUfcj/qxXyey7uex5ud+yMAD3bE9JdIt6dJuAE14GtN6b
	lC8QmnvNefavlJM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vkQmO-004pH9-5M; Mon, 26 Jan 2026 18:53:36 +0100
Date: Mon, 26 Jan 2026 18:53:36 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Brian Vazquez <brianvv@google.com>
Cc: Brian Vazquez <brianvv.kernel@gmail.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	intel-wired-lan@lists.osuosl.org,
	David Decotigny <decot@google.com>, Li Li <boolli@google.com>,
	Anjali Singhai <anjali.singhai@intel.com>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	emil.s.tantilov@intel.com, Brett Creeley <brett.creeley@amd.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: Re: [iwl-net PATCH v2] idpf: change IRQ naming to match netdev and
 ethtool queue numbering
Message-ID: <b18b4b38-b3e7-485f-91f8-e3a74ff90572@lunn.ch>
References: <20260126144624.2319784-1-brianvv@google.com>
 <37e1a648-609b-4d5e-9176-fbbacc7e9e07@lunn.ch>
 <CAMzD94Qt9-5G-8MHcmHLgYEyjRUoPB+SruzZXafxSTkNV8criA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMzD94Qt9-5G-8MHcmHLgYEyjRUoPB+SruzZXafxSTkNV8criA@mail.gmail.com>

On Mon, Jan 26, 2026 at 12:40:15PM -0500, Brian Vazquez wrote:
> On Mon, Jan 26, 2026 at 11:24 AM Andrew Lunn <andrew@lunn.ch> wrote:
> >
> > On Mon, Jan 26, 2026 at 02:46:24PM +0000, Brian Vazquez wrote:
> > > The code uses the vidx for the IRQ name but that doesn't match ethtool
> > > reporting or netdev naming, this makes it hard to tune the device and
> > > associate queues with IRQs. Sequentially requesting irqs starting from
> > > '0' makes the output consistent.
> > >
> > > Before:
> > >
> > > ethtool -L eth1 tx 1 combined 3
> > >
> > > grep . /proc/irq/*/*idpf*/../smp_affinity_list
> > > /proc/irq/67/idpf-Mailbox-0/../smp_affinity_list:0-55,112-167
> > > /proc/irq/68/idpf-eth1-TxRx-1/../smp_affinity_list:0
> > > /proc/irq/70/idpf-eth1-TxRx-3/../smp_affinity_list:1
> > > /proc/irq/71/idpf-eth1-TxRx-4/../smp_affinity_list:2
> > > /proc/irq/72/idpf-eth1-Tx-5/../smp_affinity_list:3
> > >
> > > ethtool -S eth1 | grep -v ': 0'
> > > NIC statistics:
> > >      tx_q-0_pkts: 1002
> > >      tx_q-1_pkts: 2679
> > >      tx_q-2_pkts: 1113
> > >      tx_q-3_pkts: 1192 <----- tx_q-3 vs idpf-eth1-Tx-5
> > >      rx_q-0_pkts: 1143
> > >      rx_q-1_pkts: 3172
> > >      rx_q-2_pkts: 1074
> > >
> > > After:
> > >
> > > ethtool -L eth1 tx 1 combined 3
> > >
> > > grep . /proc/irq/*/*idpf*/../smp_affinity_list
> > >
> > > /proc/irq/67/idpf-Mailbox-0/../smp_affinity_list:0-55,112-167
> > > /proc/irq/68/idpf-eth1-TxRx-0/../smp_affinity_list:0
> > > /proc/irq/70/idpf-eth1-TxRx-1/../smp_affinity_list:1
> > > /proc/irq/71/idpf-eth1-TxRx-2/../smp_affinity_list:2
> > > /proc/irq/72/idpf-eth1-Tx-3/../smp_affinity_list:3
> > >
> > > ethtool -S eth1 | grep -v ': 0'
> > > NIC statistics:
> > >      tx_q-0_pkts: 118
> > >      tx_q-1_pkts: 134
> > >      tx_q-2_pkts: 228
> > >      tx_q-3_pkts: 138 <--- tx_q-3 matches idpf-eth1-Tx-3
> > >      rx_q-0_pkts: 111
> > >      rx_q-1_pkts: 366
> > >      rx_q-2_pkts: 120
> >
> > Are there any ABI issues here?
> 
> The patch doesn't change the format, it just fixes the numbering in
> the name to make it consistent with other reporting tools. It
> shouldn't break any library.

But is the numbering part of the ABI?

Making a comment about ABI in the commit message makes it clear it is
something you have considered, and you have decided it is not an
issue. If there is no such comment, reviewers probably should ask.

       Andrew
