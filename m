Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D7E332628
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 03:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785726409; cv=none; b=NG1QnJTh/rrrtmP48/TMPptZkEZ8AbIbia/ECZq5fcfF6ohCeCcKDF0g1W4oSl0BUgjguxivKRLJVFbIs526lQ+WG/iCKs9hbcz3p7cpCEDDeTpcyYaTqR2A+GIWfEhn/wIH17Bd7du5RjLuhSHCCidJcQBXg0kIadmkFa2qsMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785726409; c=relaxed/simple;
	bh=9y8A3ixVmnfAoBRcrSB73RJB9vL/v/t+a9iKLN2wIVo=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=b/Ld3F2DADs3ywT7pMHDuCK/FxlKhn021oiyq5C5t2t15rbR8rtjdIg3p5pw4WGZ9y+tjkeLPxkx0Pakp9e8VsF5UoWYCpjDSxuErycfes9plAc1gxk4oUnADpK7GqvDE0PbejSgvu888DcZqQRzA+8OXNtVBC5rd9qzQIclDhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.204.34.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid:tivesync6t1785726389t03ecd43d
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com [122.235.139.83])
X-QQ-SSF:0000000000000000000000000000000
From: =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 3037987298578021087
To: "'Simon Horman'" <horms@kernel.org>
Cc: <netdev@vger.kernel.org>,
	"'Mengyuan Lou'" <mengyuanlou@net-swift.com>,
	"'Andrew Lunn'" <andrew+netdev@lunn.ch>,
	"'David S. Miller'" <davem@davemloft.net>,
	"'Eric Dumazet'" <edumazet@google.com>,
	"'Jakub Kicinski'" <kuba@kernel.org>,
	"'Paolo Abeni'" <pabeni@redhat.com>,
	"'Arend van Spriel'" <arend.vanspriel@broadcom.com>,
	"'Jijie Shao'" <shaojijie@huawei.com>,
	"'Rongguang Wei'" <weirongguang@kylinos.cn>,
	=?iso-8859-1?Q?'Uwe_Kleine-K=F6nig_=28The_Capable_Hub=29'?= <u.kleine-koenig@baylibre.com>,
	"'Joe Damato'" <joe@dama.to>,
	"'Larysa Zaremba'" <larysa.zaremba@intel.com>
References: <21947C51A754F86C+20260728093554.9324-1-jiawenwu@trustnetic.com> <20260731135046.GI51943@horms.kernel.org>
In-Reply-To: <20260731135046.GI51943@horms.kernel.org>
Subject: RE: [PATCH net] net: ngbe: fix NULL pointer dereference in non-MSI-X interrupt enabling
Date: Mon, 3 Aug 2026 11:06:28 +0800
Message-ID: <058b01dd22f5$14072f50$3c158df0$@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: zh-cn
Thread-Index: AQFqT0y0mbKT69dqN2ZUmemCC0hMFgEi5kWFt2gfMqA=
X-QQ-SENDSIZE: 520
Feedback-ID: tivesync:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: M3ZkD08p3wd5AGQE2C+MhW7hLGERfLI9iExAJSbkV2iHxtJfM8R8xPKY
	Q5mz8ZslXEtAKcl70O/11JQSFrCGg/sriZjAtnYIVJz76th0OPsj46xY0z3k0oByPsq30C8
	YNJUQz6IuJd2aPfIncpVmA5qjgniRzN+Tz0UXhU7Co61FxXvdTbhw9JKJlCN4QfXGj3ROoV
	ehFRVWdgrgXJHIWmc9/HpTAxhJEHTB3tWWEZtku2EnWi+SDbkQaIuLH20FbV7O/pGRuVLRX
	pIBgdmPtvl6gOosfz/HFjN+Vn8RFR96l6xWPvxd/F6Gm1mxGruJ1E+sC3UN4BIGJiEUYWCj
	d5NUYKHA53P4j905kmZ4bhjI90pwViE5FLhlQtI0DbRT/YpZCdUzG9WwJy7ADb4oSCNc2db
	YVvuxuuRzUjP4Q5hMicLcbB6tqDQ0a1dz1xdkZ+bN1Dw9w6146UNZAhvDAoXpYS+EsPvEiS
	kks+c2fdWCaZt30cCOonkvDbet11NvMTYDKTU/9WQhCpcYfBGw5Km0E/42il2QpiDSpLYyT
	O7S9LdTuiplMvL1ideh5UCnjZ7yGdmMnKPjftQewsMba0ORLKD17Ks3UY82AYwNvLdHOXPY
	5nnVgF7SmEtlnTVmh9AThjMhB8PpQ0ydDW7suOyYbGt2oBWzU0LljyYXvcIYimlMYJHmIaw
	tGiD5sdBZ5mpOJ4syGMRMWigCGEGqW5rVnd+4MYqfurbIM6cx1FW/00t2ln9xlfG8CGERZr
	9c28l3oiEtUn0qsdtpZlabZY1b9xVM7K4Y8B3BMRPDhFC2yiFi5X20WF03cLJF90Hw9z3QG
	+BepsDBvzve/+2HQGEZ/olb/u48WfDu5NmO84hXDYgmJRU/dvGKAOpQ0UIJ9XJiA64Izw6H
	AlWJ+I3Kf8i0zI2IjfzQUvQV1yPhuLIwCCnoXuEmRrdU9f8GOzyE/03tjSEt+yWTlhHDKt1
	7yhkLC0U7o2N5Z+MoFqK5D+AoQk6qpt5KVyHfwqwOvj9eYftZoMvTbP/4iDZx9IsVaXVtX4
	+jQE0hDInvLAGXJzzl40x4a1RKZQtMpuQV5gzRgOuk+BBqEpI4LjdgcuOwLgHnMytrLhKiy
	NM0bwANy3qv
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
X-QQ-RECHKSPAM: 0

On Fri, Jul 31, 2026 9:51 PM, Simon Horman wrote:
> On Tue, Jul 28, 2026 at 05:35:54PM +0800, Jiawen Wu wrote:
> > In non-MSI-X mode (such as legacy INTx or single MSI), wx->msix_entry is
> > not allocated or initialized. Calling NGBE_INTR_MISC(wx) dereferences
> > wx->msix_entry->entry, leading to a NULL pointer dereference crash.
> >
> > This issue was introduced by fixing the IRQ vector when the number of
> > VFs is 7. Since macro NGBE_INTR_MISC is used in only one place and
> > relies on MSI-X allocation, remove it.
> >
> > Fix the issue by explicitly checking WX_FLAG_IRQ_VECTOR_SHARED to
> > determine the correct vector index and using BIT() to convert it into
> > the interrupt mask required by wx_intr_enable().
> >
> > Fixes: 4174c0c331a2 ("net: ngbe: specify IRQ vector when the number of VFs is 7")
> > Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
> > ---
> >  drivers/net/ethernet/wangxun/ngbe/ngbe_main.c | 4 +++-
> >  drivers/net/ethernet/wangxun/ngbe/ngbe_type.h | 1 -
> >  2 files changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
> > index a16221995909..5d89fc84e8bc 100644
> > --- a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
> > +++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
> > @@ -180,8 +180,10 @@ static void ngbe_irq_enable(struct wx *wx, bool queues)
> >  	/* mask interrupt */
> >  	if (queues)
> >  		wx_intr_enable(wx, NGBE_INTR_ALL);
> > +	else if (test_bit(WX_FLAG_IRQ_VECTOR_SHARED, wx->flags))
> > +		wx_intr_enable(wx, BIT(0));
> 
> Hi Jiawen,
> 
> I am wondering if you could take a look over the following issue
> which is included in the AI-generated review on sashiko.dev [1]
> 
> [1] https://sashiko.dev/#/patchset/21947C51A754F86C%2B20260728093554.9324-1-jiawenwu%40trustnetic.com
> 
>   Does this change introduce a desynchronization between the software state
>   and the hardware configuration if SR-IOV enablement fails?
> 
>   If pci_enable_sriov() fails inside wx_pci_sriov_enable(), the error path
>   clears the WX_FLAG_IRQ_VECTOR_SHARED flag via wx_sriov_clear_data():

Looks like a bad time to clear the flag...
I'll change it to check pdev->msix_enabled but not the flag.

> 
>   wx_pci_sriov_enable() {
>       ...
>       err = pci_enable_sriov(wx->pdev, num_vfs);
>       if (err) {
>           ...
>           goto err_out;
>       }
>       ...
>   err_out:
>       wx_sriov_clear_data(wx);
>       return err;
>   }
> 
>   However, the hardware was already re-initialized with the MISC interrupt
>   mapped to vector 0. Since the hardware configuration isn't reverted, won't
>   subsequent shared interrupts cause the hardware to auto-mask vector 0, which
>   will then never be unmasked here because the flag was cleared? This appears
>   to result in a permanent masking of Queue 0 and MISC events.
> 
> >  	else
> > -		wx_intr_enable(wx, NGBE_INTR_MISC(wx));
> > +		wx_intr_enable(wx, BIT(wx->num_q_vectors));
> >  }
> >
> >  /**
>



