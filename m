Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792528352;
	b=xTneP5z2oJkcAj/l6LDVpZ9FGVV5vszlxU5YAsR5YHk0iH8IFQR4Gmrb2DaqZTfF1TAG
	 PZJpQIWLIVBVDOvraab9tY6wVBlIMs1Lskd0z/2y+DFw/tdRiRpuwDf0iScTKuoKpAqwZ
	 0BrEibadPIiPwSde63xtKcvJFv6PPgdAkTJfQgyJ9LoohE3CFaK7T48AxIx88CaXrnyFi
	 eWqmu9m1/yr1Xw70rVSXwXCniVl9CEWJP0f8GrVvHpi8oQr3ZefxAJQYZg9rL0N9yhBdU
	 p+9A2FvpiZR6imfiE0sGcieD5X9dh1qlNi9jt1c2hz+7kqf6020r+GIIKSBLHH3iHWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792528352;
	h=Received:DKIM-Signature:Received:Received:X-ME-Sender:X-ME-Received:
	 X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=ZkWQE/uALqfLnZKuscsosAHo1zEUz4R5lm4SmlWWw6w=;
	b=p3A3UTQH9CethCQC2tMCTBSRTEujqgcd9YKeUWfJ8DcRdpXxzzKtYQ1eyTrW1IgSi1P3
	 Omw08N0q6dn9mekCNlaEv3XXKKkGY/tAVpQ8xWxx3rlixuYWdVX/8i/WX9k2AXKJCBla+
	 nDann6pXQqwfLkHeBPKj69hlwbAKecstPG4JT7KC3nXFdvx2hSy04gE9sqXuOErq+3Tk6
	 u+OgOdnx/TIQxawzcuBZkOOqA3r6HBQEBHvd+hSQu/KJLt5FsIM0PIYMSv9h4Vsr0YQew
	 CEItByLJ+chGZSmyQPMEilNLX5bcH7Li5Ka1JJXgryPeG1XZ5yObcW28vSXOlRh4ipg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Gkq5TCq8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2150606A31B
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 20:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Gkq5TCq8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DECA41F000CA;
	Tue, 20 Oct 2026 20:32:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792528351;
	bh=ZkWQE/uALqfLnZKuscsosAHo1zEUz4R5lm4SmlWWw6w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Gkq5TCq80SSQskzQkfsgHUu2HSuSGc2Oma4YCr3nINfDqKXggEiwb73ITrV5JWm33
	 pxLn2/TngXZISnhZ9YdLBKz6+QgYL13L7SNfjTuYuTSmNMp0tww2AHOyeHc6xWhXPC
	 ghrrO1bi8QeyJ71g+Ouz2T+YA2Eag/4UHprOsAQjQrKuOXE28t81olCd3k79j3u7xn
	 C+fi1MXADW+CzgbApqf03EWF6PSoNQgubxBilMUMIUyy6j4TcRODsun2DGoLMLYyQ/
	 M40boy1QIk2NHM3G+b74wx4n65Lmh6xF0J7U5URhMOOpJMa9nVXQryE2fJmSVc7yMf
	 4nTHQAVFho+ww==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id 0E7C8F4006B;
	Tue, 20 Oct 2026 16:32:30 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 20 Oct 2026 16:32:30 -0400
X-ME-Sender: <xms:3s_XamN42F183gxMSO2a_dH2dOTn1d7hJoYI6qhAoV2_jio4lXkL2w>
    <xme:3s_Xap0LasOYBCh50uK7ALGn3NvYnW18g-8lJ9UIpt5RruCceNUhlmZjEAXxpd0Vx
    nc7-j6Hl0D_AeI60gVcDBIPCCdwLU40_0horMMH0N1uiaG9oEaQSf0>
X-ME-Received: <xmr:3s_Xal1InojV7R7LAGL7hua-2NBFRmRnnrcVfP5gCDdJi_kHMmyxEEVTgfiOB9s_yraPKyjLJFkRaAk7RxgKT3voYrSfqRKa>
X-ME-Proxy-Cause: dmFkZTF2jD+MaXG7JBc6kMXRFqJOwuJfgs6TtjLrVebZcy1oGq69rP+skQs/Q55fcuR+hP
    dfOwQXHwP0n0T/4mX/xRrgdyTMsXGJeEojmwqRazHVvRzeptbDaLb1X0Lqe+/U78n5p0YT
    n+kNVD9LgQrvUZaqpz2azFY8EBZcZYbfTwELiJdrnj7ojVEUi3oytPg9Phv8o71pJ/FjvN
    o2EPTS04NWPTbygPRy+m9kzkNV+KBGQrB0ol291C5DgE4mjXWciYXJCweQZNTdpe5hJQNt
    LqdpBpdKYkQCjLh6phrlhg8DGIWr2d7vgaNwCi+hayS6Z6+UWWsnxpQA6DzobiGBGGDauI
    1Su7SHOYPoYQKX5XVb0grr6MPWB3iMC44UYNKCdT50t/0vgDs4VWwLUPVLes9OrfM27vWl
    EwBFf520/RLSi3SkQDCxTjsnTI6fBKd3FWMeTUcdCz2oqButbZ1rtWnYf0Y/Nyw6iKAGN0
    TlT2l962IFu82q0dIk5olwo8QUoCy8rw76J5RIqZg6f9T5xrtSg2x0Az8fWToKxP2U2Ofp
    r3QUR3mMVrZVadZi69zGNrhEh9KYleUXDMuNJTL+7YG34nJAOQCihYnXzmx+LIRQ/G02R7
    QOX4D4Kdj6mXBTufPQ1IxU/fC09AUNMv37vSjHlG6b8jz1yvd+VOyduhI2ug
X-ME-Proxy: <xmx:3s_Xan-sJ5hctZHYIj2ooDyZC_LMHhd_Velr9G36LPhzdE66xtHWJw>
    <xmx:3s_XahZzBp70_C5oUv30CAFDWebM2OkgGZY8nTLYakCfsdTAmQl4Qw>
    <xmx:3s_Xamyu35PIA4Eo6qYHlXisAzjeQmB08Vv-7en9b7Z9fJOYy8Mg0w>
    <xmx:3s_Xav8E7ttZeS01BqXbvCBAtbTCVI5fJIOgR-yNKngHoD-B6PRJ3w>
    <xmx:3s_XaizRRPpmZg0Mw0sP9ak_DgKL77ZXrdSAGg-gH9E0OBtYHECJDNxd>
Feedback-ID: i8dbe485b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 Oct 2026 16:32:29 -0400 (EDT)
Date: Tue, 20 Oct 2026 13:32:28 -0700
From: Boqun Feng <boqun@kernel.org>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Vlad Poenaru <vlad.wing@gmail.com>, netdev@vger.kernel.org,
	Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Davide Caratti <dcaratti@redhat.com>,
	Breno Leitao <leitao@debian.org>,
	Nilay Shroff <nilay@linux.ibm.com>, linux-kernel@vger.kernel.org,
	Vlad Poenaru <thevlad@meta.com>
Subject: Re: [PATCH net-next 0/2] net/sched: don't wait for RCU when
 destroying qdisc lockdep keys
Message-ID: <atfP3PyUjF6pKh--@tardis.local>
References: <20261019170225.729789-1-vlad.wing@gmail.com>
 <atZtYi_Xnz27O8Bp@tardis.local>
 <c3de29a9-8edf-4186-bc26-82d1d68c4c78@acm.org>
 <ateu_3PV81VuFK1i@tardis.local>
 <9b33cc28-9e30-4bdb-aa1e-cd8dec149833@acm.org>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9b33cc28-9e30-4bdb-aa1e-cd8dec149833@acm.org>

On Tue, Oct 20, 2026 at 01:21:28PM -0700, Bart Van Assche wrote:
> On 10/20/26 11:12 AM, Boqun Feng wrote:
> > Is there any context that I'm missing that you want to shut up this
> > discussion and rush the change in?
> 
> I'm not trying to shut up anything or rush in anything. All I did is to
> share my opinion.
> 

Phew. I value your input but note the Vlad already offered some options
to resolve my concern [1]. It'll be valuable to examine these first in
my opinion.

[1]: https://lore.kernel.org/lkml/20261020125335.678200-1-vlad.wing@gmail.com/

Regards,
Boqun

> Bart.
