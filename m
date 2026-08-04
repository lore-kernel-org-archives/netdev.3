Received: from flow-a3-smtp.messagingengine.com (flow-a3-smtp.messagingengine.com [103.168.172.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CDC347427C
	for <netdev@vger.kernel.org>; Tue,  4 Aug 2026 16:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785860942; cv=none; b=UdzrrbtYm6SYZmHWRTLMEZirnE4+qiCqqK8jrkueaKwWdcinnayIAsyIXk5OdU46S6MkP1ci5C/t6hYUEWa0GY/JSjizxsP+ER7UjOh5hTtksxtZ0e6rwjcQ5bz0KWGhlTobtS5y5sxJ0TEEZNbFR5CefkBfLfYZReRIaluTfI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785860942; c=relaxed/simple;
	bh=+27Vj7ECPpTn/COujroRuTfhnd0Q1dG7F8MYQFfM3+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YABZ+m/VwF5q4HIPRJfkMgwb5xfVp5zA4AYS5XVpVjejqLecAqDJahDyENLps7xn/B5+AMwo43x2BvcDlUJNIALWxFB4MsSRZOvpElQ0dSqe5Oy9ynaGWODpG+GGegikfPjVkeMqkjkzVEReDw/5RRg9uTl7Ql/ASpJ09/siUNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=cO4RLz5u; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OlloxurV; arc=none smtp.client-ip=103.168.172.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="cO4RLz5u";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OlloxurV"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailflow.phl.internal (Postfix) with ESMTP id 90E001380372;
	Tue,  4 Aug 2026 12:28:59 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 04 Aug 2026 12:28:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1785860939; x=1785868139; bh=vGQ9aTJvph
	JrV6ZBYhomn2DAFIInsouYHFNO8U7YiAY=; b=cO4RLz5u3cPKiuzPerNSvoIjWl
	i9UTGWvR61D+PU+T7PzhWWtbLSgVI4XTmmr/R7CC46ZNKjJ41uJwNEhImIiACDPL
	5Rgcwh6mjMvOiu3MRphyA64gGbALSzu6gyM1bq+sasuqPKpm1cukYcJZWx3VDsMR
	Dg3maZ1eExs4TpNAvCoaEoz5WGJXNKMHgpcyWeSGHNuekoQAtg/E38xnds4KJGB9
	75dWl2sJPWXvrtza71j1st9BCnrcYY8TuNA+X2qO7pQ2XBueGt/TN+FecOYzmhbu
	ED4PHPux+L3g/3WN5e/vTlDWiWVK3R0ayrCMbNqh2vmoo8w17Izd2hboPcGw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1785860939; x=1785868139; bh=vGQ9aTJvphJrV6ZBYhomn2DAFIInsouYHFN
	O8U7YiAY=; b=OlloxurVpC+aCEMElQFzPaUkfGU4zHROfQDhGDI9rx2+HtRpwdz
	lAfooy2Aggu+nAFVNq0DCssDmVaVDepSKcPJ4PfoyPQzX0H2aEOpueCx/wIEX1gD
	nzYZp+eIo7Y22PkGrXEt84pkDW4UkcG1a00DZ73A1/UkDuHP12g5BVckqJ7qcH41
	Mm4zUDqxZEVSe9zPF+RBo63JbulqPsn9lPSndWhESWEAIZZijFQe6f01V0Y25kng
	wsqJgEyws/zGv8sa+v7x0zfk4slpRJ5wnGuHhpx0Kf84tler73N26iomTDn/KHbi
	/b35+SOURqZZDwoGPHpE626wFi9mO5gbQ4Q==
X-ME-Sender: <xms:SxNyarblW4FO9fOndX3A_CATD-Ej0NL-8chcbxQXhA8Mg3h_eIcYSw>
    <xme:SxNyahYTeZ9T_YxznFjgvoiBI3cHe2Yl_G0gb6UM1VKohlY69pkB9RTTzx8HZ7oDx
    Z0YkBHuNb54hnaQAq_PJoLKJp7EBtcNc2ITbCikQY2PBYSG0ldQLWk>
X-ME-Received: <xmr:SxNyai_y5Mczg41uFKrltUBvGFV4rzcrFSpwGJLID16wcDAUC_dIRXcAGhm-zU0twRDERVtKAHJvppRQp9g6XKxIpeuObWs>
X-ME-Proxy-Cause: dmFkZTFOKfE0FfnCDVX7Z73mdEJ90FfJOeduvDp6PPGCB0snIilfA5/KyNn4yH2WP0AM1D
    hooWTMPIfAyjE7BUakUGAZTolhxobLmuUe8BGeFZuKo0kLTGlS3/p4aqZ+p7wkDlTuD2dK
    pKdeCiHYmtPiSdhYmPTNlWASOwaHaHPHQGz7B6DZl4sWfGD6RPhsDT4b6lNj0krxFs4nQ0
    m3Ayw1B6AtGf9t5c6jDmheEfXD1J6VAinhlkUwDTx5gBk/tBTkwerp57G+FHhJgHEuaV8p
    jIfQkc7+l2LnrR9vuba5kXh+A3oRbpkJ3u3KsXG3gXUh0gvAbiz1lzekPubiHw7QkOLhio
    JfVtUN37IOLPWXTQliAczbe6v7wbtjbjFG++OqrXoiDkMFaLqO7D7kdhJBpoY1eN2JPFaf
    T/rtJqOJHrglsCWFNcJSMR1ceGdxw78QrLzTuJCVci9rF76zJ8dz1DjLTbQ+fPbISNuOhf
    BPoXuM7KowgUgat7TWBLKNa4xkzMQcfCc9WfnBucRcJ/+PxcbFsmD4O0xvXnbHr9NfwWzC
    Mz7uk4pcfgclLMz3FQKtzx8vTywa1ktFtzuk5+Df95kKQLNEFKML6a+BUxiH5iMMnpUZp1
    ucrzT1MRIaO/GMU3OTVDdE2rt+RMqxiA0NPnrZLRvBjHyx26hP33+5/DuqdA
X-ME-Proxy: <xmx:SxNyaghmhawCeDlrXlXmMePI75yVqPJavVFi8GeyjeVsZy5UHhOXwg>
    <xmx:SxNyaifXGPs1JC0vlzBWfAaqR11b4mSNeXj4Cl1Mo7eLhMomDuyu7w>
    <xmx:SxNyanrzarMYhoGtGXHI7GaCGtsd2UcI_moTGugLcESYMlEMWEYXzA>
    <xmx:SxNyanBarEOkzE0sDN54eMmbe9hqctnb8MMusoNSsclWmcNVrnDnIQ>
    <xmx:SxNyakGggcDCgwf6JJP0Sl5t62LgmIbuV1PpcdssAcMGXZANg1T6rKbj>
Feedback-ID: i80b64ba7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Aug 2026 12:28:59 -0400 (EDT)
Date: Tue, 4 Aug 2026 11:28:58 -0500
From: Juanlu Herrero <juanlu@fastmail.com>
To: David Wei <dw@davidwei.uk>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, 
	Pavel Begunkov <asml.silence@gmail.com>
Subject: Re: [PATCH net-next v4 4/6] selftests: net: add multithread client
 support to iou-zcrx
Message-ID: <anITF0eIGOVCgc-a@jlhe0197-mac>
References: <20260729221825.42773-1-juanlu@fastmail.com>
 <20260729221825.42773-5-juanlu@fastmail.com>
 <beb62270-ddb2-40d1-b03d-fd612073c4e7@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <beb62270-ddb2-40d1-b03d-fd612073c4e7@davidwei.uk>

On Tue, Aug 04, 2026 at 08:47:33AM -0600, David Wei wrote:
> On 2026-07-29 15:18, Juanlu Herrero wrote:
> > Add pthreads to the iou-zcrx client so that multiple connections can be
> > established simultaneously. Each client thread connects to the server
> > and sends its payload independently.
> > 
> > Introduce the -t option to control the number of threads (default 1),
> > preserving backwards compatibility with existing tests.
> > 
> > Assisted-by: Claude:claude-opus-4-8
> > Signed-off-by: Juanlu Herrero <juanlu@fastmail.com>
> > ---
> >   .../testing/selftests/drivers/net/hw/Makefile |  2 +-
> >   .../selftests/drivers/net/hw/iou-zcrx.c       | 38 +++++++++++++++++--
> >   2 files changed, 36 insertions(+), 4 deletions(-)
> > 
> > diff --git a/tools/testing/selftests/drivers/net/hw/Makefile b/tools/testing/selftests/drivers/net/hw/Makefile
> > index 234db5c2c90cc..3cab3b4adbb2e 100644
> > --- a/tools/testing/selftests/drivers/net/hw/Makefile
> > +++ b/tools/testing/selftests/drivers/net/hw/Makefile
> > @@ -88,5 +88,5 @@ include ../../../net/ynl.mk
> >   include ../../../net/bpf.mk
> >   ifeq ($(HAS_IOURING_ZCRX),y)
> > -$(OUTPUT)/iou-zcrx: LDLIBS += -luring
> > +$(OUTPUT)/iou-zcrx: LDLIBS += -luring -lpthread
> >   endif
> > diff --git a/tools/testing/selftests/drivers/net/hw/iou-zcrx.c b/tools/testing/selftests/drivers/net/hw/iou-zcrx.c
> > index 9b62fd0703e61..7bc61f3b70ca6 100644
> > --- a/tools/testing/selftests/drivers/net/hw/iou-zcrx.c
> > +++ b/tools/testing/selftests/drivers/net/hw/iou-zcrx.c
> > @@ -4,6 +4,7 @@
> >   #include <error.h>
> >   #include <fcntl.h>
> >   #include <limits.h>
> > +#include <pthread.h>
> >   #include <stdbool.h>
> >   #include <stdint.h>
> >   #include <stdio.h>
> > @@ -85,9 +86,12 @@ static int cfg_send_size = SEND_SIZE;
> >   static struct sockaddr_in6 cfg_addr;
> >   static unsigned int cfg_rx_buf_len;
> >   static bool cfg_dry_run;
> > +static int cfg_num_threads = 1;
> >   static char *payload;
> > +#define CONNS_PER_THREAD	4
> > +
> >   struct thread_ctx {
> >   	struct io_uring		ring;
> >   	void			*area_ptr;
> > @@ -379,7 +383,7 @@ static void run_server(void)
> >   		error(1, 0, "test failed\n");
> >   }
> > -static void run_client(void)
> > +static void *client_worker(void *arg)
> >   {
> >   	ssize_t to_send = cfg_send_size;
> >   	ssize_t sent = 0;
> > @@ -405,12 +409,37 @@ static void run_client(void)
> >   	}
> >   	close(fd);
> > +	return NULL;
> > +}
> > +
> > +static void run_client(void)
> > +{
> > +	int conns_per_thread = cfg_num_threads > 1 ? CONNS_PER_THREAD : 1;
> 
> Make cfg_num_threads the default value you want, then you can remove
> CONNS_PER_THREAD and this ternary.

seems cleaner, I will fix that in v5 and thanks for the review.

Best,
Juanlu
